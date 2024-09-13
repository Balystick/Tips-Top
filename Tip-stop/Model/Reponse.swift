//
//  Reponse.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

struct Reponse: Codable,Identifiable {
    let id:UUID
    var date: Date
    var contenu: String
    var utilisateur: Utilisateur
}
