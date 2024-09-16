//
//  Favoris.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

/// Une structure représentant un favori avec des informations détaillées.
///
/// La structure `Favori` est utilisée pour modéliser les données d'un favori,
/// incluant un identifiant unique, la date d'ajout et l'astuce associée.
///
/// Conformément au protocole `Identifiable`, chaque favori a un identifiant unique généré automatiquement.
struct Favori: Codable {
    /// La date à laquelle l'astuce a été ajoutée aux favoris.
    var dateAjout: String
    
    /// L'astuce associée à ce favori.
    var astuce: Astuce
}
