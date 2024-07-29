//
//  DecouverteViewModel.swift
//  Tip-stop
//
//  Created by Aurélien on 18/07/2024.
//
import Foundation

class DecouverteViewModel: ObservableObject {
    @Published var categories: [Categorie] = [
        Categorie(
            titre: "Photo & Vidéo",
            description: "Découvrez et maîtrisez toutes les fonctionnalités photo et vidéo de votre iPhone.",
            image: "photo.on.rectangle"
        )
    ]
    
    init(categories: [Categorie], topics: [Topic]) {
        self.categories = categories
    }
}

