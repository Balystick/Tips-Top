//
//  ProfileViewModel.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation
import SwiftUI

/// Une classe représentant le modèle de vue pour le profil de l'utilisateur.
///
/// La classe `ProfileViewModel` est utilisée pour gérer et fournir les données de profil
/// de l'utilisateur, incluant ses favoris et ses informations personnelles.
/// Cette classe conforme au protocole `ObservableObject` permet de notifier les vues de tout changement.
class ProfileViewModel: ObservableObject {
    @ObservedObject var globalDataModel: GlobalDataModel

    /// La liste des favoris de l'utilisateur.
    @Published var favoris: [Favori]
    
    /// Les informations de l'utilisateur.
    @Published var utilisateur: Utilisateur
    
    /// Initialise une nouvelle instance de `ProfileViewModel` avec une liste de favoris et les informations de l'utilisateur.
    ///
    /// - Parameters:
    ///   - favoris: Une liste d'objets de type `Favori`.
    ///   - utilisateur: Un objet de type `Utilisateur` représentant l'utilisateur.
    init(globalDataModel: GlobalDataModel, favoris: [Favori], utilisateur: Utilisateur) {
        self.globalDataModel = globalDataModel
        self.favoris = favoris
        self.utilisateur = utilisateur
    }
    
    /// Ajoute un nouvel utilisateur avec un nom vide et les mêmes informations de photo que l'utilisateur actuel.
    ///
    /// Cette fonction crée une nouvelle instance de `Utilisateur` avec un nom vide,
    /// la même photo que l'utilisateur actuel et une liste de favoris vide.
    func addUtilisateur() {
        var user = Utilisateur(nom: "", photo: utilisateur.photo, favoris: [])
        // Ici, il pourrait y avoir un code pour ajouter cet utilisateur quelque part.
    }
}
