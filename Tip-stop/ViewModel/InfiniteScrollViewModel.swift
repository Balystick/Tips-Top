//
//  InfiniteScrollViewModel.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import SwiftUI
import Foundation
import Combine

class InfiniteScrollViewModel: ObservableObject {
    @Published var astuces: [Astuce] = []
    private var currentAstuceIndex = 0

    init() {
        loadLikesFromStorage()
        loadMoreAstuces()
    }

    func loadMoreAstuces() {
        let newAstuces = getPredefinedAstuces().dropFirst(currentAstuceIndex).prefix(10)
        astuces.append(contentsOf: newAstuces)
        currentAstuceIndex += newAstuces.count
    }

    private func getPredefinedAstuces() -> [Astuce] {
        return [
            Astuce(
                titre: "How to Use SwiftUI",
                video: "Vid1",
                dateDeCreation: Date(),
                pourcentageVue: 75,
                nombreDeLikes: getStoredLikeCount(for: "How to Use SwiftUI"),
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
                titre: "How to Use SwiftUI",
                video: "Vid2",
                dateDeCreation: Date(),
                pourcentageVue: 75,
                nombreDeLikes: getStoredLikeCount(for: "How to Use SwiftUI"),
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
                titre: "How to Use SwiftUI",
                video: "Vid3",
                dateDeCreation: Date(),
                pourcentageVue: 75,
                nombreDeLikes: getStoredLikeCount(for: "How to Use SwiftUI"),
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

    func toggleLike(for astuce: Astuce) {
        var updatedAstuce = astuce
        let isLiked = getStoredLikeStatus(for: astuce.titre)

        if isLiked {
            // Remove like
            updatedAstuce.nombreDeLikes -= 1
            removeLikeStatus(for: astuce.titre)
            updateStoredLikeCount(for: astuce.titre, count: updatedAstuce.nombreDeLikes)
        } else {
            // Add like
            updatedAstuce.nombreDeLikes += 1
            saveLikeStatus(for: astuce.titre)
            updateStoredLikeCount(for: astuce.titre, count: updatedAstuce.nombreDeLikes)
        }

        // Update the list
        if let index = astuces.firstIndex(where: { $0.titre == astuce.titre }) {
            astuces[index] = updatedAstuce
        }
    }

    func toggleFavorite(for astuce: Astuce) {
        let isFavorited = getStoredFavorite(for: astuce.titre)
        
        if isFavorited {
            removeFavorite(for: astuce.titre)
        } else {
            saveFavorite(for: astuce.titre)
        }
    }

    private func loadLikesFromStorage() {
        // This method should ideally be used to update the likes of each Astuce based on stored data
        for index in astuces.indices {
            let titre = astuces[index].titre
            let storedLikes = getStoredLikeCount(for: titre)
            astuces[index].nombreDeLikes = storedLikes
        }
    }

    // MARK: - Storage Handling

    private func saveLikeStatus(for titre: String) {
        var likedTitles = UserDefaults.standard.stringArray(forKey: "likedTitles") ?? []
        if !likedTitles.contains(titre) {
            likedTitles.append(titre)
            UserDefaults.standard.set(likedTitles, forKey: "likedTitles")
        }
    }

    private func removeLikeStatus(for titre: String) {
        var likedTitles = UserDefaults.standard.stringArray(forKey: "likedTitles") ?? []
        if let index = likedTitles.firstIndex(of: titre) {
            likedTitles.remove(at: index)
            UserDefaults.standard.set(likedTitles, forKey: "likedTitles")
        }
    }

    func getStoredLikeStatus(for titre: String) -> Bool {
        let likedTitles = UserDefaults.standard.stringArray(forKey: "likedTitles") ?? []
        return likedTitles.contains(titre)
    }

    func getStoredLikeCount(for titre: String) -> Int {
        let storedLikes = UserDefaults.standard.integer(forKey: "likeCount_\(titre)")
        return storedLikes
    }

    private func updateStoredLikeCount(for titre: String, count: Int) {
        UserDefaults.standard.set(count, forKey: "likeCount_\(titre)")
    }

    private func saveFavorite(for titre: String) {
        var favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
        if !favoritedTitles.contains(titre) {
            favoritedTitles.append(titre)
            UserDefaults.standard.set(favoritedTitles, forKey: "favoritedTitles")
        }
    }

    private func removeFavorite(for titre: String) {
        var favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
        if let index = favoritedTitles.firstIndex(of: titre) {
            favoritedTitles.remove(at: index)
            UserDefaults.standard.set(favoritedTitles, forKey: "favoritedTitles")
        }
    }

    func getStoredFavorite(for titre: String) -> Bool {
        let favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
        return favoritedTitles.contains(titre)
    }
}
