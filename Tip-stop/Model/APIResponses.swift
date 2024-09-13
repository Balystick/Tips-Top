//
//  APIResponses.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 9/12/24.
//

import Foundation

struct CategorieResponse: Codable {
    let id: String
    let titre: String
    let description: String
    let icon: String
    let astuces: [AstuceResponse]
    let topics: [TopicResponse]
}

struct AstuceResponse: Codable {
    let titre: String
    let video: String
    let dateDeCreation: String
    let pourcentageVue: Int
    let nombreDeLikes: Int
    let categorie: CategorieResponse
    let steps: [StepResponse]
    let commentaires: [CommentaireResponse]
    let id: String
}

struct CommentaireResponse: Codable {
    let contenu: String
    let date: String
    let nombreDeLikes: Int
    let utilisateur: UtilisateurResponse
}

struct StepResponse: Codable {
    let num: Int
    let titre: String
    let description: String
    let isSelected: Bool
}

struct TopicResponse: Codable {
    let dateDebut: String
    let sujet: String
    let reponse: [ReponseResponse]
    let categorie: CategorieResponse
}

struct ReponseResponse: Codable {
    let contenu: String
    let utilisateur: UtilisateurResponse
}

struct UtilisateurResponse: Codable {
    let nom: String
    let photo: String?
    let favoris: [FavoriResponse]
}

struct FavoriResponse: Codable {
    let dateAjout: String
    let astuce: AstuceResponse
}
