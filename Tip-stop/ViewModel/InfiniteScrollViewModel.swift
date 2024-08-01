//
//  InfiniteScrollViewModel.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation
import Combine

class InfiniteScrollViewModel: ObservableObject {
    @Published var astuces: [Astuce] = []
    
    private var currentAstuceIndex = 1

    init() {
        loadMoreAstuces()
    }

    func loadMoreAstuces() {
        let newAstuces = (currentAstuceIndex..<currentAstuceIndex + 10).map { index in
            let videoName = "Vid\(index % 10 + 1)"
            return Astuce(
                titre: "Astuce \(index)",
                video: videoName,
                dateDeCreation: Date(),
                pourcentageVue: Int.random(in: 0...100),
                nombreDeLikes: Int.random(in: 0...1000),
                steps: (1...5).map { Step(titre: "Step \($0) Title", description: "Step \($0) description for Astuce \(index)") },
                commentaires: (1...5).map { Commentaire(
                    contenu: "Comment content \($0) for Astuce \(index)",
                    date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short),
                    nombreDeLikes: Int.random(in: 0...100),
                    utilisateur: Utilisateur(
                        nom: "User \($0)",
                        photo: "user_photo_\($0)",
                        favoris: []
                    )
                )}
            )
        }
        astuces.append(contentsOf: newAstuces)
        currentAstuceIndex += 10
    }
}
