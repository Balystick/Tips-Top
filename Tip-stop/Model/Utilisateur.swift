//
//  Utilisateur.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

struct Utilisateur: Identifiable {
    let id = UUID()
    var nom: String
    var photo: String
    var favoris: [Favori]

}
