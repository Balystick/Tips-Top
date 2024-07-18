//
//  Commentaire.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

struct Commentaire: Identifiable {
    let id = UUID()
    var contenu: String
    var date: String
    var nombreDeLikes: Int
    var utilisateur: Utilisateur
}
