//
//  Categorie.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

struct Categorie: Identifiable {
    let id = UUID()
    let titre: String
    let description: String
    let icon: String
    var astuces: [Astuce]?
    var topics: [Topic]?
}
