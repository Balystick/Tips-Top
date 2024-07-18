//
//  Favoris.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

struct Favori: Identifiable {
    let id = UUID()
    var dateAjout: Date
    var utilisateur: Utilisateur
}
