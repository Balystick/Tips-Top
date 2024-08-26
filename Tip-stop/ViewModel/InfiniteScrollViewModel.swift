//
//  InfiniteScrollViewModel.swift
//  Tip-stop
//

import SwiftUI
import Foundation
import Combine

class InfiniteScrollViewModel: ObservableObject {
    // Liste des astuces actuellement chargées
    @Published var astuces: [Astuce] = []
    // Dictionnaire stockant l'état de "like" des astuces par leur index
    @Published var isLiked: [Int: Bool] = [:]
    // Dictionnaire stockant l'état de "favori" des astuces par leur index
    @Published var isFavorited: [Int: Bool] = [:]
    // Index utilisé pour savoir où reprendre le chargement des prochaines astuces
    private var currentAstuceIndex = 0

    init() {
        loadMoreAstuces()
        loadInitialState()  // Précharge les états des "likes" et "favoris"
    }

    func loadMoreAstuces() {
        let newAstuces = getPredefinedAstuces().dropFirst(currentAstuceIndex).prefix(10)
        astuces.append(contentsOf: newAstuces)
        currentAstuceIndex += newAstuces.count
        loadInitialState()
    }
    
    /// Charge l'état initial des "likes" et "favoris" pour les astuces chargées
    func loadInitialState() {
        for index in astuces.indices {
            let video = astuces[index].video
            
            // Initialise l'état des likes à partir de UserDefaults (si l'utilisateur a déjà liké)
            isLiked[index] = getStoredLikeStatus(for: video)
            
            // Initialise l'état des favoris à partir de UserDefaults
            isFavorited[index] = getStoredFavorite(for: video)
            
            // Charge le nombre de likes stocké dans UserDefaults
            if let storedLikes = UserDefaults.standard.value(forKey: "likeCount_\(video)") as? Int {
                astuces[index].nombreDeLikes = storedLikes
            }
        }
    }

    /// Renvoie une liste d'astuces pré-définies pour la simulation du chargement
    /// - Returns: Un tableau d'objets `Astuce`
    private func getPredefinedAstuces() -> [Astuce] {
        return [
            Astuce(
                titre: "How to Use SwiftUI 1",
                video: "Vid1",
                dateDeCreation: Date(),
                pourcentageVue: 75,
                nombreDeLikes: 302,
                categorie: Categorie(
                    titre: "Découverte",
                    description: "Maximiser votre efficacité au quotidien",
                    icon: "Découverte",
                    astuces: [],
                    topics: []
                ),
                steps: [
                    Step(num: 1, titre: "Setup", description: "Set up your Xcode project for SwiftUI.", isSelected: false),
                    Step(num: 2, titre: "Basic Views", description: "Learn about basic SwiftUI views.", isSelected: false),
                    Step(num: 3, titre: "State Management", description: "Understand state management in SwiftUI.", isSelected: false)
                ],
                commentaires: [
                    Commentaire(
                        contenu: "Great tutorial!",
                        date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short),
                        nombreDeLikes: 15,
                        utilisateur: Utilisateur(
                            nom: "John Doe",
                            photo: UIImage(named: "user_photo_1"),
                            favoris: []
                        )
                    )
                ]
            ),
            Astuce(
                titre: "How to Use SwiftUI 2",
                video: "Vid2",
                dateDeCreation: Date(),
                pourcentageVue: 75,
                nombreDeLikes: 275,
                categorie: Categorie(
                    titre: "Personnalisation",
                    description: "Maximiser votre efficacité au quotidien",
                    icon: "Personnalisation",
                    astuces: [],
                    topics: []
                ),
                steps: [
                    Step(num: 1, titre: "Setup", description: "Set up your Xcode project for SwiftUI.", isSelected: false),
                    Step(num: 2, titre: "Basic Views", description: "Learn about basic SwiftUI views.", isSelected: false),
                    Step(num: 3, titre: "State Management", description: "Understand state management in SwiftUI.", isSelected: false)
                ],
                commentaires: [
                    Commentaire(
                        contenu: "Great tutorial!",
                        date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short),
                        nombreDeLikes: 15,
                        utilisateur: Utilisateur(
                            nom: "John Doe",
                            photo: UIImage(named: "user_photo_1"),
                            favoris: []
                        )
                    )
                ]
            ),
            Astuce(
                titre: "How to Use SwiftUI 3",
                video: "Vid3",
                dateDeCreation: Date(),
                pourcentageVue: 75,
                nombreDeLikes: 627,
                categorie: Categorie(
                    titre: "Productivité",
                    description: "Maximiser votre efficacité au quotidien",
                    icon: "Productivité",
                    astuces: [],
                    topics: []
                ),
                steps: [
                    Step(num: 1, titre: "Setup", description: "Set up your Xcode project for SwiftUI.", isSelected: false),
                    Step(num: 2, titre: "Basic Views", description: "Learn about basic SwiftUI views.", isSelected: false),
                    Step(num: 3, titre: "State Management", description: "Understand state management in SwiftUI.", isSelected: false)
                ],
                commentaires: [
                    Commentaire(
                        contenu: "Great tutorial!",
                        date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short),
                        nombreDeLikes: 15,
                        utilisateur: Utilisateur(
                            nom: "John Doe",
                            photo: UIImage(named: "user_photo_1"),
                            favoris: []
                        )
                    )
                ]
            ),
            Astuce(
                titre: "How to Use SwiftUI 5",
                video: "Vid5",
                dateDeCreation: Date(),
                pourcentageVue: 75,
                nombreDeLikes: 940,
                categorie: Categorie(
                    titre: "Productivité",
                    description: "Maximiser votre efficacité au quotidien",
                    icon: "Productivité",
                    astuces: [],
                    topics: []
                ),
                steps: [
                    Step(num: 1, titre: "Setup", description: "Set up your Xcode project for SwiftUI.", isSelected: false),
                    Step(num: 2, titre: "Basic Views", description: "Learn about basic SwiftUI views.", isSelected: false),
                    Step(num: 3, titre: "State Management", description: "Understand state management in SwiftUI.", isSelected: false)
                ],
                commentaires: [
                    Commentaire(
                        contenu: "Great tutorial!",
                        date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short),
                        nombreDeLikes: 15,
                        utilisateur: Utilisateur(
                            nom: "John Doe",
                            photo: UIImage(named: "user_photo_1"),
                            favoris: []
                        )
                    )
                ]
            ),
            Astuce(
                titre: "How to Use SwiftUI 7",
                video: "Vid7",
                dateDeCreation: Date(),
                pourcentageVue: 75,
                nombreDeLikes: 36,
                categorie: Categorie(
                    titre: "Productivité",
                    description: "Maximiser votre efficacité au quotidien",
                    icon: "Productivité",
                    astuces: [],
                    topics: []
                ),
                steps: [
                    Step(num: 1, titre: "Setup", description: "Set up your Xcode project for SwiftUI.", isSelected: false),
                    Step(num: 2, titre: "Basic Views", description: "Learn about basic SwiftUI views.", isSelected: false),
                    Step(num: 3, titre: "State Management", description: "Understand state management in SwiftUI.", isSelected: false)
                ],
                commentaires: [
                    Commentaire(
                        contenu: "Great tutorial!",
                        date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short),
                        nombreDeLikes: 15,
                        utilisateur: Utilisateur(
                            nom: "John Doe",
                            photo: UIImage(named: "user_photo_1"),
                            favoris: []
                        )
                    )
                ]
            ),
            Astuce(
                titre: "How to Use SwiftUI 8",
                video: "Vid8",
                dateDeCreation: Date(),
                pourcentageVue: 75,
                nombreDeLikes: 618,
                categorie: Categorie(
                    titre: "Productivité",
                    description: "Maximiser votre efficacité au quotidien",
                    icon: "Productivité",
                    astuces: [],
                    topics: []
                ),
                steps: [
                    Step(num: 1, titre: "Setup", description: "Set up your Xcode project for SwiftUI.", isSelected: false),
                    Step(num: 2, titre: "Basic Views", description: "Learn about basic SwiftUI views.", isSelected: false),
                    Step(num: 3, titre: "State Management", description: "Understand state management in SwiftUI.", isSelected: false)
                ],
                commentaires: [
                    Commentaire(
                        contenu: "Great tutorial!",
                        date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short),
                        nombreDeLikes: 15,
                        utilisateur: Utilisateur(
                            nom: "John Doe",
                            photo: UIImage(named: "user_photo_1"),
                            favoris: []
                        )
                    )
                ]
            ),
            Astuce(
                titre: "How to Use SwiftUI 9",
                video: "Vid9",
                dateDeCreation: Date(),
                pourcentageVue: 75,
                nombreDeLikes: 274,
                categorie: Categorie(
                    titre: "Productivité",
                    description: "Maximiser votre efficacité au quotidien",
                    icon: "Productivité",
                    astuces: [],
                    topics: []
                ),
                steps: [
                    Step(num: 1, titre: "Setup", description: "Set up your Xcode project for SwiftUI.", isSelected: false),
                    Step(num: 2, titre: "Basic Views", description: "Learn about basic SwiftUI views.", isSelected: false),
                    Step(num: 3, titre: "State Management", description: "Understand state management in SwiftUI.", isSelected: false)
                ],
                commentaires: [
                    Commentaire(
                        contenu: "Great tutorial!",
                        date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short),
                        nombreDeLikes: 15,
                        utilisateur: Utilisateur(
                            nom: "John Doe",
                            photo: UIImage(named: "user_photo_1"),
                            favoris: []
                        )
                    )
                ]
            )
            // Add more predefined Astuce objects here
        ]
    }
    
    // MARK: - Gestion des likes

    /// Alterne l'état "like" d'une astuce
    func toggleLike(for astuce: Astuce) {
        guard let index = astuces.firstIndex(where: { $0.video == astuce.video }) else { return }

        var updatedAstuce = astuce
        var likedVideos = UserDefaults.standard.stringArray(forKey: "likedVideos") ?? []

        if likedVideos.contains(astuce.video) {
            // Supprime le like
            updatedAstuce.nombreDeLikes -= 1
            if let likedIndex = likedVideos.firstIndex(of: astuce.video) {
                likedVideos.remove(at: likedIndex)
            }
        } else {
            // Ajoute le like
            updatedAstuce.nombreDeLikes += 1
            likedVideos.append(astuce.video)
        }

        // Mise à jour du UserDefaults
        UserDefaults.standard.set(likedVideos, forKey: "likedVideos")
        UserDefaults.standard.set(updatedAstuce.nombreDeLikes, forKey: "likeCount_\(astuce.video)")

        // Mise à jour de l'astuce dans la liste
        astuces[index] = updatedAstuce
        objectWillChange.send()
    }

    /// Récupère le nombre de likes stocké pour une vidéo spécifique
    /// - Parameter video: Le nom de la vidéo
    /// - Returns: Le nombre de likes
    func getStoredLikeCount(for video: String) -> Int {
        return UserDefaults.standard.integer(forKey: "likeCount_\(video)")
    }

    /// Récupère l'état "like" stocké pour une vidéo spécifique
    /// - Parameter video: Le nom de la vidéo
    /// - Returns: `true` si la vidéo est likée, `false` sinon
    func getStoredLikeStatus(for video: String) -> Bool {
        let likedVideos = UserDefaults.standard.stringArray(forKey: "likedVideos") ?? []
        return likedVideos.contains(video)
    }

    // MARK: - Gestion des favoris

    /// Alterne l'état "favori" d'une astuce donnée
    /// - Parameter astuce: L'astuce pour laquelle l'état "favori" doit être alterné
    func toggleFavorite(for astuce: Astuce) {
        let isFavorited = getStoredFavorite(for: astuce.video)
        
        if isFavorited {
            removeFavorite(for: astuce.video)
        } else {
            saveFavorite(for: astuce.video)
        }
    }

    /// Sauvegarde une vidéo comme favori
    /// - Parameter video: Le nom de la vidéo
    private func saveFavorite(for video: String) {
        var favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
        if !favoritedTitles.contains(video) {
            favoritedTitles.append(video)
            UserDefaults.standard.set(favoritedTitles, forKey: "favoritedTitles")
        }
    }

    /// Supprime une vidéo des favoris
    /// - Parameter video: Le nom de la vidéo
    private func removeFavorite(for video: String) {
        var favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
        if let index = favoritedTitles.firstIndex(of: video) {
            favoritedTitles.remove(at: index)
            UserDefaults.standard.set(favoritedTitles, forKey: "favoritedTitles")
        }
    }

    /// Récupère l'état "favori" stocké pour une vidéo spécifique
    /// - Parameter video: Le nom de la vidéo
    /// - Returns: `true` si la vidéo est favorite, `false` sinon
    func getStoredFavorite(for video: String) -> Bool {
        let favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
        return favoritedTitles.contains(video)
    }
}
