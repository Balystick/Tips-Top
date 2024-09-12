//
//  Topic.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

/// Une structure représentant un sujet de discussion avec des informations détaillées.
///
/// La structure `Topic` est utilisée pour modéliser les données d'un sujet de discussion,
/// incluant un identifiant unique, une date de début, un sujet, une liste de réponses,
/// et la catégorie associée.
///
/// Conformément au protocole `Identifiable`, chaque sujet de discussion a un identifiant unique généré automatiquement.
struct Topic: Codable, Identifiable {
    /// L'identifiant unique du sujet de discussion.
    let id: UUID
    
    /// La date de début du sujet de discussion.
    var dateDebut: Date
    
    /// Le sujet de discussion.
    var sujet: String
    
    /// La liste des réponses associées au sujet de discussion.
    ///
    /// La propriété `reponse` est un tableau d'éléments de type `Reponse`, représentant les réponses
    /// des utilisateurs au sujet de discussion.
    var reponse: [Reponse]
    
    /// La catégorie associée au sujet de discussion.
    var categorie: Categorie
}
