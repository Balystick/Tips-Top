//
//  Categorie.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import SwiftUI

/// Une structure représentant une catégorie avec des informations détaillées.
///
/// La structure `Categorie` est utilisée pour modéliser les données d'une catégorie,
/// incluant un identifiant unique, un titre, une description, une icône, et des listes
/// d'astuces et de sujets connexes.
///
/// Conformément au protocole `Identifiable`, chaque catégorie a un identifiant unique généré automatiquement.
struct Categorie: Identifiable {
    /// L'identifiant unique de la catégorie.
    let id = UUID()
    
    /// Le titre de la catégorie.
    let titre: String
    
    /// La description de la catégorie.
    let description: String
    
    /// L'icône représentant la catégorie.
    ///
    /// Cette propriété est une chaîne de caractères représentant le nom de l'icône.
    let icon: String
    
    /// La liste des astuces associées à la catégorie.
    ///
    /// La propriété `astuces` est un tableau d'éléments de type `Astuce`, représentant les astuces
    /// associées à cette catégorie.
    var astuces: [Astuce]
    
    /// La liste des sujets (topics) associés à la catégorie.
    ///
    /// La propriété `topics` est un tableau d'éléments de type `Topic`, représentant les sujets
    /// connexes à cette catégorie.
    var topics: [Topic]
}
