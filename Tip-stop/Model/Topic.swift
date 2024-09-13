//
//  Topic.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

struct Topic: Codable,Identifiable {
    let id:UUID
    var dateDebut: Date
    var sujet: String
    var reponse: [Reponse]
    var categorie: Categorie
}
