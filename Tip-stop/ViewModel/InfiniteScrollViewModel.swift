//
//  InfiniteScrollViewModel.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024
//  Modified by Aurélien
//

import SwiftUI
import Foundation
import Combine

class InfiniteScrollViewModel: ObservableObject {
    @Published var astuces: [Astuce] = []
    @Published var isLiked: [UUID: Bool] = [:]
    @Published var isFavorited: [UUID: Bool] = [:]
    private var currentPage = 1
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadMoreAstuces()
    }

    func loadMoreAstuces() {
        guard let url = URL(string: "https://azure-systematic-orangutan-728.mypinata.cloud/ipfs/QmXb4wm3bkeUJcd6vc9BHMNd7Ga7Pj9LT568TURVEHiqWA") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [AstuceResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] astuceResponses in
                guard let self = self else { return }
                let newAstuces = astuceResponses.map { response in
                    Astuce(
                        id: UUID(),
                        titre: response.titre,
                        video: response.video,
                        dateDeCreation: ISO8601DateFormatter().date(from: response.dateDeCreation) ?? Date(),
                        pourcentageVue: response.pourcentageVue,
                        nombreDeLikes: response.nombreDeLikes,
                        categorie: Categorie( // Generate a new UUID if you don’t have it in the response
                            id: UUID(),
                            titre: response.categorie.titre,
                            description: response.categorie.description,
                            icon: response.categorie.icon,
                            astuces: [], // Nested `Astuce` if applicable
                            topics: [] // Nested `Topic` if applicable
                        ),
                        steps: response.steps.map { step in
                            Step(
                                id: UUID(),
                                num: step.num,
                                titre: step.titre,
                                description: step.description,
                                isSelected: step.isSelected
                            )
                        },
                        commentaires: response.commentaires.map { comment in
                            Commentaire(
                                id: UUID(),
                                contenu: comment.contenu,
                                date: comment.date,
                                nombreDeLikes: comment.nombreDeLikes,
                                utilisateur: Utilisateur(
                                    id: UUID(),
                                    nom: comment.utilisateur.nom,
// Modif Merge                      photo: UIImage(named: comment.utilisateur.photo ?? ""),
                                    photo: "",
                                    favoris: [] // Handle nested `Favori` if needed
                                )
                            )
                        }
                    )
                }
                self.astuces.append(contentsOf: newAstuces)
                self.currentPage += 1
                self.loadInitialState()
            }
            .store(in: &cancellables)
    }
    
    func loadInitialState() {
        for index in astuces.indices {
            let video = astuces[index].video
            isLiked[astuces[index].id] = getStoredLikeStatus(for: video)
            isFavorited[astuces[index].id] = getStoredFavorite(for: video)
            if let storedLikes = UserDefaults.standard.value(forKey: "likeCount_\(video)") as? Int {
                astuces[index].nombreDeLikes = storedLikes
            }
        }
    }

    // MARK: - Gestion des likes

    func toggleLike(for astuce: Astuce) {
        guard let index = astuces.firstIndex(where: { $0.id == astuce.id }) else { return }

        var updatedAstuce = astuce
        var likedVideos = UserDefaults.standard.stringArray(forKey: "likedVideos") ?? []

        if likedVideos.contains(astuce.video) {
            updatedAstuce.nombreDeLikes -= 1
            if let likedIndex = likedVideos.firstIndex(of: astuce.video) {
                likedVideos.remove(at: likedIndex)
            }
        } else {
            updatedAstuce.nombreDeLikes += 1
            likedVideos.append(astuce.video)
        }

        UserDefaults.standard.set(likedVideos, forKey: "likedVideos")
        UserDefaults.standard.set(updatedAstuce.nombreDeLikes, forKey: "likeCount_\(astuce.video)")

        astuces[index] = updatedAstuce
        objectWillChange.send()
    }

    func getStoredLikeCount(for video: String) -> Int {
        return UserDefaults.standard.integer(forKey: "likeCount_\(video)")
    }

    func getStoredLikeStatus(for video: String) -> Bool {
        let likedVideos = UserDefaults.standard.stringArray(forKey: "likedVideos") ?? []
        return likedVideos.contains(video)
    }

    // MARK: - Gestion des favoris

    func toggleFavorite(for astuce: Astuce) {
        let isFavorited = getStoredFavorite(for: astuce.video)
        
        if isFavorited {
            removeFavorite(for: astuce.video)
        } else {
            saveFavorite(for: astuce.video, category: astuce.categorie.titre)
        }
    }
    
    private func saveFavorite(for video: String, category: String) {
        var favoritedVideos = UserDefaults.standard.array(forKey: "favoritedVideos") as? [[String: String]] ?? []
        if !favoritedVideos.contains(where: { $0["title"] == video }) {
            let newFavorite = ["title": video, "category": category]
            favoritedVideos.append(newFavorite)
            UserDefaults.standard.set(favoritedVideos, forKey: "favoritedVideos")
        }
    }
    
    private func removeFavorite(for video: String) {
        var favoritedVideos = UserDefaults.standard.array(forKey: "favoritedVideos") as? [[String: String]] ?? []
        if let index = favoritedVideos.firstIndex(where: { $0["title"] == video }) {
            favoritedVideos.remove(at: index)
            UserDefaults.standard.set(favoritedVideos, forKey: "favoritedVideos")
        }
    }
    
    func getStoredFavorite(for video: String) -> Bool {
        let favoritedVideos = UserDefaults.standard.array(forKey: "favoritedVideos") as? [[String: String]] ?? []
        return favoritedVideos.contains(where: { $0["title"] == video })
    }
}










////
////  InfiniteScrollViewModel.swift
////  Tip-stop
////
////  Created by Apprenant 122 on 18/07/2024
////  Modified by Aurélien
////
//
//import SwiftUI
//import Foundation
//import Combine
//
//class InfiniteScrollViewModel: ObservableObject {
//    // Liste des astuces actuellement chargées
//    @Published var astuces: [Astuce] = []
//    // Dictionnaire stockant l'état de "like" des astuces par leur index
//    @Published var isLiked: [Int: Bool] = [:]
//    // Dictionnaire stockant l'état de "favori" des astuces par leur index
//    @Published var isFavorited: [Int: Bool] = [:]
//    // Index utilisé pour savoir où reprendre le chargement des prochaines astuces
//    private var currentAstuceIndex = 0
//
//    init() {
//        loadMoreAstuces()
//        loadInitialState()  // Précharge les états des "likes" et "favoris"
//    }
//
//    func loadMoreAstuces() {
//        let newAstuces = getPredefinedAstuces().dropFirst(currentAstuceIndex).prefix(10)
//        astuces.append(contentsOf: newAstuces)
//        currentAstuceIndex += newAstuces.count
//        loadInitialState()
//    }
//    
//    /// Charge l'état initial des "likes" et "favoris" pour les astuces chargées
//    func loadInitialState() {
//        for index in astuces.indices {
//            let video = astuces[index].video
//            
//            // Initialise l'état des likes à partir de UserDefaults (si l'utilisateur a déjà liké)
//            isLiked[index] = getStoredLikeStatus(for: video)
//            
//            // Initialise l'état des favoris à partir de UserDefaults
//            isFavorited[index] = getStoredFavorite(for: video)
//            
//            // Charge le nombre de likes stocké dans UserDefaults
//            if let storedLikes = UserDefaults.standard.value(forKey: "likeCount_\(video)") as? Int {
//                astuces[index].nombreDeLikes = storedLikes
//            }
//        }
//    }
//
//    /// Renvoie une liste d'astuces pré-définies pour la simulation du chargement
//    /// - Returns: Un tableau d'objets `Astuce`
//    private func getPredefinedAstuces() -> [Astuce] {
//        return [
//            Astuce(
//                id: UUID(),
//                titre: "How to Use SwiftUI 1",
//                video: "Vid1",
//                dateDeCreation: Date(),
//                pourcentageVue: 75,
//                nombreDeLikes: 302,
//                categorie: Categorie(
//                    id: UUID(),
//                    titre: "Découverte",
//                    description: "Maximiser votre efficacité au quotidien",
//                    icon: "Découverte",
//                    astuces: [],
//                    topics: []
//                ),
//                steps: [
//                    Step(id: UUID(), num: 1, titre: "Setup", description: "Set up your Xcode project for SwiftUI.", isSelected: false),
//                    Step(id: UUID(), num: 2, titre: "Basic Views", description: "Learn about basic SwiftUI views.", isSelected: false),
//                    Step(id: UUID(), num: 3, titre: "State Management", description: "Understand state management in SwiftUI.", isSelected: false)
//                ],
//                commentaires: [
//                    Commentaire(
//                        id: UUID(),
//                        contenu: "Great tutorial!",
//                        date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short),
//                        nombreDeLikes: 15,
//                        utilisateur: Utilisateur(
//                            id: UUID(),
//                            nom: "John Doe",
////                            photo: UIImage(named: "user_photo_1"),
//                            photo: "user_photo_1",
//                            favoris: []
//                        )
//                    )
//                ]
//            )
//            ]
//            // Add more predefined Astuce objects here
//    
//    }
//    
//    // MARK: - Gestion des likes
//
//    /// Alterne l'état "like" d'une astuce
//    func toggleLike(for astuce: Astuce) {
//        guard let index = astuces.firstIndex(where: { $0.video == astuce.video }) else { return }
//
//        var updatedAstuce = astuce
//        var likedVideos = UserDefaults.standard.stringArray(forKey: "likedVideos") ?? []
//
//        if likedVideos.contains(astuce.video) {
//            // Supprime le like
//            updatedAstuce.nombreDeLikes -= 1
//            if let likedIndex = likedVideos.firstIndex(of: astuce.video) {
//                likedVideos.remove(at: likedIndex)
//            }
//        } else {
//            // Ajoute le like
//            updatedAstuce.nombreDeLikes += 1
//            likedVideos.append(astuce.video)
//        }
//
//        // Mise à jour du UserDefaults
//        UserDefaults.standard.set(likedVideos, forKey: "likedVideos")
//        UserDefaults.standard.set(updatedAstuce.nombreDeLikes, forKey: "likeCount_\(astuce.video)")
//
//        // Mise à jour de l'astuce dans la liste
//        astuces[index] = updatedAstuce
//        objectWillChange.send()
//    }
//
//    /// Récupère le nombre de likes stocké pour une vidéo spécifique
//    /// - Parameter video: Le nom de la vidéo
//    /// - Returns: Le nombre de likes
//    func getStoredLikeCount(for video: String) -> Int {
//        return UserDefaults.standard.integer(forKey: "likeCount_\(video)")
//    }
//
//    /// Récupère l'état "like" stocké pour une vidéo spécifique
//    /// - Parameter video: Le nom de la vidéo
//    /// - Returns: `true` si la vidéo est likée, `false` sinon
//    func getStoredLikeStatus(for video: String) -> Bool {
//        let likedVideos = UserDefaults.standard.stringArray(forKey: "likedVideos") ?? []
//        return likedVideos.contains(video)
//    }
//
//    // MARK: - Gestion des favoris
//
//    /// Alterne l'état "favori" d'une astuce donnée
//    /// - Parameter astuce: L'astuce pour laquelle l'état "favori" doit être alterné
//    func toggleFavorite(for astuce: Astuce) {
//        let isFavorited = getStoredFavorite(for: astuce.video)
//        
//        if isFavorited {
//            removeFavorite(for: astuce.video)
//        } else {
//            saveFavorite(for: astuce.video)
//        }
//    }
//
//    /// Sauvegarde une vidéo comme favori
//    /// - Parameter video: Le nom de la vidéo
//    private func saveFavorite(for video: String) {
//        var favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
//        if !favoritedTitles.contains(video) {
//            favoritedTitles.append(video)
//            UserDefaults.standard.set(favoritedTitles, forKey: "favoritedTitles")
//        }
//    }
//
//    /// Supprime une vidéo des favoris
//    /// - Parameter video: Le nom de la vidéo
//    private func removeFavorite(for video: String) {
//        var favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
//        if let index = favoritedTitles.firstIndex(of: video) {
//            favoritedTitles.remove(at: index)
//            UserDefaults.standard.set(favoritedTitles, forKey: "favoritedTitles")
//        }
//    }
//
//    /// Récupère l'état "favori" stocké pour une vidéo spécifique
//    /// - Parameter video: Le nom de la vidéo
//    /// - Returns: `true` si la vidéo est favorite, `false` sinon
//    func getStoredFavorite(for video: String) -> Bool {
//        let favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
//        return favoritedTitles.contains(video)
//    }
//}
