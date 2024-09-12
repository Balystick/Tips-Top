//
//  SuggestionsManager.swift
//  Tip-stop
//
//  Created by Aurélien on 12/09/2024.
//

import Foundation

class SuggestionsManager: ObservableObject {
    // Les astuces recommandées pour l'utilisateur.
    @Published var recommendedAstuces: [Astuce] = []
    
    private let userDefaults = UserDefaults.standard
    private let profileKey = "userProfile"
    private let viewedVideosKey = "viewedVideos"
    
    // Enregistrement du profil utilisateur dans UserDefaults
    private var storedProfile: [String: Int] {
        get {
            return userDefaults.dictionary(forKey: profileKey) as? [String: Int] ?? [:]
        }
        set {
            userDefaults.set(newValue, forKey: profileKey)
        }
    }
    
    // Enregistrement de l'historique des vidéos vues dans UserDefaults
    private var storedViewedVideos: [String] {
        get {
            return userDefaults.stringArray(forKey: viewedVideosKey) ?? []
        }
        set {
            userDefaults.set(newValue, forKey: viewedVideosKey)
        }
    }
    
    // Le profil utilisateur, qui contient les points accumulés par l'utilisateur dans chacunes des catégories en fonction de ses intéractions
    @Published var profile: [String: Int] = [:]
    
    // L'historique des vidéos vues par l'utilisateur
    @Published var viewedVideos: [String] = []
    
    init() {
        self.profile = storedProfile
        self.viewedVideos = storedViewedVideos
        recommendVideos()
    }
    
    
    // Possibilité d'ajouter ici une gestion des références croisées pour assurer la cohérence des données (Categorie/Astuce, Categorie/Topic)
    
    
    /// Met à jour le profil utilisateur en fonction de ses interactions avec l'app
    ///
    /// - Parameters:
    ///   - categorie: La catégorie de fonctionnaités avec laquelle l'utilisateur a interagi
    ///   - interactionType: Le type d'interaction, tel que "like", "favorite", "comment", "view", "search", "reply".
    ///   - astuce: Une astuce optionnelle liée à l'interaction (éventuellement pour affiner par la suite)
    func updateUserProfile(categorie: Categorie, interactionType: String, astuce: Astuce? = nil) {
        let points: Int
        
        switch interactionType {
        case "like":
            points = 10
        case "favorite":
            points = 20
        case "comment":
            points = 15
        case "view":
            points = 5
        case "search":
            points = 5
        case "reply":
            points = 10
        default:
            points = 0
        }
        
        if profile[categorie.titre] == nil {
            profile[categorie.titre] = 0
        }
        profile[categorie.titre]! += points
        
        // Update stored profile
        storedProfile = profile
        recommendVideos()
    }
    
    /// Recommande des vidéos basées sur le profil de l'utilisateur et l'historique des vidéos qu'il a vu
    func recommendVideos() {
        let sortedCategories = profile.sorted { $0.value > $1.value }
        var recommendedAstuces: [Astuce] = []
        
        for (categoryTitle, _) in sortedCategories {
            if let category = GlobalViewModel.shared.categories.first(where: { $0.titre == categoryTitle }) {
                let newAstuces = category.astuces.filter { !viewedVideos.contains($0.titre) }
                recommendedAstuces.append(contentsOf: newAstuces)
            }
        }
        
        self.recommendedAstuces = recommendedAstuces
    }
}
