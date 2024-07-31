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
            image: "Productivité"
        ),
        Categorie(
            titre: "Photo & Vidéo",
            description: "Découvrez et maîtrisez toutes les fonctionnalités photo et vidéo de votre iPhone.",
            image: "Personnalisation"
        ),
        Categorie(
            titre: "Photo & Vidéo",
            description: "Découvrez et maîtrisez toutes les fonctionnalités photo et vidéo de votre iPhone.",
            image: "Performance"
        ),
        Categorie(
            titre: "Photo & Vidéo",
            description: "Découvrez et maîtrisez toutes les fonctionnalités photo et vidéo de votre iPhone.",
            image: "Accessibilité"
        ),
        Categorie(
            titre: "Photo & Vidéo",
            description: "Découvrez et maîtrisez toutes les fonctionnalités photo et vidéo de votre iPhone.",
            image: "Sécurité"
        )
    ]
    
    init(categories: [Categorie] = []) {
        if !categories.isEmpty {
                   self.categories = categories
               }
    }
    
    func getCarouselImages() -> [CarouselImage] {
        return categories.map { CarouselImage(id: $0.id, image: $0.image) }
    }
}

struct CarouselImage: Identifiable {
    var id: UUID
    var image: String
}

