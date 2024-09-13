//
//  Reponse.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

/// Une structure représentant une réponse avec des informations détaillées.
///
/// La structure `Reponse` est utilisée pour modéliser les données d'une réponse,
/// incluant un identifiant unique, la date de publication, le contenu de la réponse,
/// et l'utilisateur qui a posté la réponse.
///
/// Conformément au protocole `Identifiable`, chaque réponse a un identifiant unique généré automatiquement.
struct Reponse: Codable, Identifiable {
    /// L'identifiant unique de la réponse.
    let id:  UUID
    
    /// La date de publication de la réponse.
    var date: String
    
    /// Le contenu textuel de la réponse.
    var contenu: String
    
    /// L'utilisateur qui a posté la réponse.
    var utilisateur: Utilisateur
}














////
////  Reponse.swift
////  Tip-stop
////
////  Created by Apprenant 122 on 18/07/2024.
////
//import Foundation
//
///// Une structure représentant une réponse avec des informations détaillées.
/////
///// La structure `Reponse` est utilisée pour modéliser les données d'une réponse,
///// incluant un identifiant unique, la date de publication, le contenu de la réponse,
///// et l'utilisateur qui a posté la réponse.
/////
///// Conformément au protocole `Identifiable`, chaque réponse a un identifiant unique généré automatiquement.
//struct Reponse: Codable, Identifiable {
//    /// L'identifiant unique de la réponse.
//    let id: UUID
//    
//    /// La date de publication de la réponse.
//    var date: Date
//    
//    /// Le contenu textuel de la réponse.
//    var contenu: String
//    
//    /// L'utilisateur qui a posté la réponse.
//    var utilisateur: Utilisateur
//}
