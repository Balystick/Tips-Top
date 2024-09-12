//
//  Utilisateur.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation
import UIKit

/// Une structure représentant un utilisateur avec des informations de base.
///
/// La structure `Utilisateur` est utilisée pour modéliser les données d'un utilisateur,
/// incluant un identifiant unique, un nom, une photo de profil optionnelle et une liste de favoris.
///
/// Conformément au protocole `Identifiable`, chaque utilisateur a un identifiant unique généré automatiquement.
struct Utilisateur: Codable, Identifiable {
    /// L'identifiant unique de l'utilisateur.
    let id: UUID
    
    /// Le nom de l'utilisateur.
    var nom: String
    
    /// La photo de profil de l'utilisateur.
    ///
    /// Cette propriété est optionnelle et peut être `nil` si l'utilisateur n'a pas de photo de profil.
    var photo: UIImage?
    
    /// La liste des favoris de l'utilisateur.
    ///
    /// La propriété `favoris` est un tableau d'éléments de type `Favori`, représentant les éléments que
    /// l'utilisateur a ajoutés à ses favoris.
    var favoris: [Favori]
}
