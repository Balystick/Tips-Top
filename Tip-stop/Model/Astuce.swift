//
//  Astuce.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

/// Une structure représentant une astuce avec des informations détaillées.
///
/// La structure `Astuce` est utilisée pour modéliser les données d'une astuce,
/// incluant un identifiant unique, un titre, une vidéo, une date de création, un pourcentage de vue,
/// un nombre de likes, une liste d'étapes et une liste de commentaires.
///
/// Conformément au protocole `Identifiable`, chaque astuce a un identifiant unique généré automatiquement.
struct Astuce: Codable {
    
    var id: String
    /// Le titre de l'astuce.
    var titre: String
    
    /// Le lien vers la vidéo de l'astuce.
    var video: String
    
    /// La date de création de l'astuce.
    var dateDeCreation: String
    
    /// Le pourcentage de la vidéo vue par les utilisateurs.
    var pourcentageVue: Int
    
    /// Le nombre de likes reçus par l'astuce.
    var nombreDeLikes: Int
    
    /// La liste des étapes pour réaliser l'astuce.
    ///
    /// La propriété `steps` est un tableau d'éléments de type `Step`, représentant les différentes
    /// étapes à suivre pour réaliser l'astuce.
    var categorie: Categorie
    var steps: [Step]
    
    /// La liste des commentaires laissés par les utilisateurs sur l'astuce.
    ///
    /// La propriété `commentaires` est un tableau d'éléments de type `Commentaire`, représentant
    /// les retours et avis des utilisateurs sur l'astuce.
    var commentaires: [Commentaire]
}
