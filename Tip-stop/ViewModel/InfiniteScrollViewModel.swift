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
                        titre: response.titre,
                        video: response.video,
                        dateDeCreation: ISO8601DateFormatter().date(from: response.dateDeCreation) ?? Date(),
                        pourcentageVue: response.pourcentageVue,
                        nombreDeLikes: response.nombreDeLikes,
                        categorie: Categorie( // Generate a new UUID if you don’t have it in the response
                            titre: response.categorie.titre,
                            description: response.categorie.description,
                            icon: response.categorie.icon,
                            astuces: [], // Nested `Astuce` if applicable
                            topics: [] // Nested `Topic` if applicable
                        ),
                        steps: response.steps.map { step in
                            Step(
                                num: step.num,
                                titre: step.titre,
                                description: step.description,
                                isSelected: step.isSelected
                            )
                        },
                        commentaires: response.commentaires.map { comment in
                            Commentaire(
                                contenu: comment.contenu,
                                date: comment.date,
                                nombreDeLikes: comment.nombreDeLikes,
                                utilisateur: Utilisateur(
                                    nom: comment.utilisateur.nom,
                                    photo: UIImage(named: comment.utilisateur.photo ?? ""),
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
            saveFavorite(for: astuce.video)
        }
    }

    private func saveFavorite(for video: String) {
        var favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
        if !favoritedTitles.contains(video) {
            favoritedTitles.append(video)
            UserDefaults.standard.set(favoritedTitles, forKey: "favoritedTitles")
        }
    }

    private func removeFavorite(for video: String) {
        var favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
        if let index = favoritedTitles.firstIndex(of: video) {
            favoritedTitles.remove(at: index)
            UserDefaults.standard.set(favoritedTitles, forKey: "favoritedTitles")
        }
    }

    func getStoredFavorite(for video: String) -> Bool {
        let favoritedTitles = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
        return favoritedTitles.contains(video)
    }
}
