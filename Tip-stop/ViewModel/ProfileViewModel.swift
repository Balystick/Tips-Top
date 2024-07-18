//
//  ProfileViewModel.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

class ProfileViewModel {
    @Published var favoris: [Favori] = []
    @Published var utilisateur: Utilisateur
    
    init() {
        utilisateur = Utilisateur.init(nom: "Nom",photo: "photo.photo")
    }
}
