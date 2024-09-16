//
//  Commentaire.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

/// Une structure représentant un commentaire avec des informations détaillées.
///
/// La structure `Commentaire` est utilisée pour modéliser les données d'un commentaire,
/// incluant un identifiant unique, le contenu du commentaire, la date de publication,
/// le nombre de likes et l'utilisateur qui a posté le commentaire.
///
/// Conformément au protocole `Identifiable`, chaque commentaire a un identifiant unique généré automatiquement.
struct Commentaire: Codable {
    
    var id: String
    /// L'identifiant unique du commentaire.
    let id: UUID
    
    /// Le contenu textuel du commentaire.
    var contenu: String
    
    /// La date de publication du commentaire.
    var date: String
    
    /// Le nombre de likes reçus par le commentaire.
    var nombreDeLikes: Int
    
    /// L'utilisateur qui a posté le commentaire.
    var utilisateur: Utilisateur
}

