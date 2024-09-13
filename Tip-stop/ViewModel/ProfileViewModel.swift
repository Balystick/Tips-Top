//
//  ProfileViewModel.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

class ProfileViewModel:ObservableObject {
    @Published var favoris: [Favori]
    @Published var utilisateur: Utilisateur
    
    init(favoris: [Favori], utilisateur: Utilisateur) {
        self.favoris = favoris
        self.utilisateur = utilisateur
    }
}
