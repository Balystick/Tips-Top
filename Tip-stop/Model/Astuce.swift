//
//  Astuce.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

struct Astuce: Identifiable {
    let id = UUID()
    var titre: String
    var video: String
    var dateDeCreation: Date
    var pourcentageVue: Int
    var nombreDeLikes: Int
    var categorie: Categorie
    var steps: [Step]
    var commentaires: [Commentaire]
}
