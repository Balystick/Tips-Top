//
//  ProfileViewModel.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation
import SwiftUI

/// Une classe représentant le modèle de vue pour le profil de l'utilisateur.
///
/// La classe `ProfileViewModel` est utilisée pour gérer et fournir les données de profil
/// de l'utilisateur, incluant ses favoris et ses informations personnelles.
/// Cette classe conforme au protocole `ObservableObject` permet de notifier les vues de tout changement.
class ProfileViewModel: ObservableObject {
    
    /// La liste des favoris de l'utilisateur.
    @Published var favoris: [Favori] = []
    
    @Published var utilisateur: Utilisateur = Utilisateur(id: UUID(), nom: "Nom par défaut", photo: "", favoris: [])
    
    @Published var filteredVideos: [Astuce] = []
    
    private let utilisateurService = UtilisateurService() // Utilisation du service
    
    //FavoriteVidéos
    let videos = UserDefaults.standard.array(forKey: "favoritedVideos") as? [[String: String]] ?? []
    
    let savedName = UserDefaults.standard.string(forKey: "name") ?? ""
    
    private var imageURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("image.jpg")
    }

    init() {
        loadName()
    }
    
    func saveImage(_ image: UIImage?) {
        guard let image = image, let data = image.jpegData(compressionQuality: 0.8) else { return }
        do {
            try data.write(to: imageURL)
//            utilisateur.photo = image
        } catch {
            print("Erreur lors de la sauvegarde de l'image: \(error)")
        }
    }

    func loadImage() {
        guard let data = try? Data(contentsOf: imageURL) else { return }
//        utilisateur.photo = UIImage(data: data)
    }
    
    // Fonction pour charger le nom de l'utilisateur depuis UserDefaults
    func loadName() {
        let savedName = UserDefaults.standard.string(forKey: "name") ?? "Nom par défaut"
        utilisateur.nom = savedName
    }

    func saveName(_ name: String) {
        UserDefaults.standard.set(name, forKey: "name")
        utilisateur.nom = name
    }
    
    /// Ajoute un nouvel utilisateur avec un nom vide et les mêmes informations de photo que l'utilisateur actuel.
    ///
    /// Cette fonction crée une nouvelle instance de `Utilisateur` avec un nom vide,
    /// la même photo que l'utilisateur actuel et une liste de favoris vide.
    func addUtilisateur() {
        var user = Utilisateur(id: UUID(), nom: "", photo: utilisateur.photo, favoris: [])
        // Ici, il pourrait y avoir un code pour ajouter cet utilisateur quelque part.
    }
    /// Récupère les informations de l'utilisateur depuis l'API.
    func fetchUtilisateur() {
        utilisateurService.fetchUtilisateur { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let utilisateur):
                    self.utilisateur = utilisateur
                case .failure(let error):
                    print("Error fetching utilisateur: \(error)")
                }
            }
        }
    }
}
