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
            titre: "Productivité",
            description: "Maximiser votre efficacité au quotidien",
            image: "Productivité"
        ),
        Categorie(
            titre: "Personnalisation",
            description: "Personnaliser votre iPhone pour une expérience utilisateur unique. Comme vous",
            image: "Personnalisation"
        ),
        Categorie(
            titre: "Utilisation Avancée",
            description: "Explorez les fonctionnalités avancées de votre iPhone, vous n'en reviendrez pas",
            image: "UtilisationAvancée"
        ),
        Categorie(
            titre: "Sécurité & Confidentialité",
            description: "Assurez la sécurité et la confidentialité de vos données grâce à des outils et des paramètres robustes",
            image: "SécuritéConfidentialité"
        ),
        Categorie(
            titre: "Connectivité et Communication",
            description: "Optimisez vos communications avec des astuces pour FaceTime, Messages, AirDrop et réseaux sociaux",
            image: "ConnectivitéCommunication"
        ),
        Categorie(
            titre: "Multimédia",
            description: "Maîtrisez l’utilisation des app Photos, Musique, Podcasts et Livres pour une expérience multimédia sans pareil",
            image: "Multimédia"
        ),
        Categorie(
            titre: "Accessibilité",
            description: "Rendez votre iPhone hyper accessible avec des fonctionnalités comme VoiceOver, AssistiveTouch et autres réglages",
            image: "Accessibilité"
        ),
        Categorie(
            titre: "Batterie et Performances",
            description: "Prolongez votre batterie et maintenez les performances optimales de votre iPhone",
            image: "BatteriePerformances"
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

