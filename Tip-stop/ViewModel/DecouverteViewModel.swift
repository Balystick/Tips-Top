//
//  DecouverteViewModel.swift
//  Tip-stop
//
//  Created by Aurélien on 18/07/2024.
//
import Foundation
import SwiftUI


/// `DecouverteViewModel` est une classe qui gère les données et la logique pour la vue de découverte.
class DecouverteViewModel: ObservableObject {
    
    /// Génère une liste d'images pour le carrousel en dupliquant les catégories (à l'exception de la catégorie "Nouveautés").
    /// - Returns: Une liste d'images dupliquées pour donner l'illusion d'un carrousel infini.
    func getCarouselImages() -> [CarouselImage] {
        let filteredCategories = GlobalViewModel.shared.categories.filter { $0.titre != "Nouveautés" }
        let duplicatedCategories = Array(repeating: filteredCategories, count: 10).flatMap { $0 }
        return duplicatedCategories.map { CarouselImage(id: UUID(), categorieTitre: $0.titre, image: $0.icon) }
    }
}

/// `CarouselImage` représente une image dans le carrousel.
/// Chaque image est identifiée de manière unique et liée à une catégorie spécifique.
struct CarouselImage: Identifiable {
    var id: UUID
    var categorieTitre: String
    var image: String
}

