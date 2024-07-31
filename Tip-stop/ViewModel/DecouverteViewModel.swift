//
//  DecouverteViewModel.swift
//  Tip-stop
//
//  Created by Aurélien on 18/07/2024.
//
import Foundation

/// `DecouverteViewModel` est une classe qui gère les données et la logique pour la vue de découverte.
class DecouverteViewModel: ObservableObject {
    
    // Liste des catégories affichées dans la vue Découverte
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
    
    /// Génère une liste d'images pour le carrousel en dupliquant les catégories.
    /// - Returns: Une liste d'images dupliquées pour donner l'illusion d'un carrousel infini.
    func getCarouselImages() -> [CarouselImage] {
        let duplicatedCategories = Array(repeating: categories, count: 10).flatMap { $0 }
        return duplicatedCategories.map { CarouselImage(id: UUID(), categoryId: $0.id, image: $0.image) }
    }
}

/// `CarouselImage` représente une image dans le carrousel.
/// Chaque image est identifiée de manière unique et liée à une catégorie spécifique.
struct CarouselImage: Identifiable {
    var id: UUID
    var categoryId: UUID
    var image: String
}

