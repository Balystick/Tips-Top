//
//  GlobalDataModel.swift
//  Tip-stop
//
//  Created by Aurélien on 07/08/2024.
//

import SwiftUI
import Combine

class GlobalDataModel: ObservableObject {
        @Published var categories: [Categorie] = [
        Categorie(
            titre: "Productivité",
            description: "Maximiser votre efficacité au quotidien",
            icon: "Productivité",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Personnalisation",
            description: "Personnaliser votre iPhone pour une expérience utilisateur unique. Comme vous",
            icon: "Personnalisation",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Utilisation Avancée",
            description: "Explorez les fonctionnalités avancées de votre iPhone, vous n'en reviendrez pas",
            icon: "UtilisationAvancée",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Sécurité & Confidentialité",
            description: "Assurez la sécurité et la confidentialité de vos données grâce à des outils et des paramètres robustes",
            icon: "SécuritéConfidentialité",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Connectivité et Communication",
            description: "Optimisez vos communications avec des astuces pour FaceTime, Messages, AirDrop et réseaux sociaux",
            icon: "ConnectivitéCommunication",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Multimédia",
            description: "Maîtrisez l’utilisation des app Photos, Musique, Podcasts et Livres pour une expérience multimédia sans pareil",
            icon: "Multimédia",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Accessibilité",
            description: "Rendez votre iPhone hyper accessible avec des fonctionnalités comme VoiceOver, AssistiveTouch et autres réglages",
            icon: "Accessibilité",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Batterie et Performances",
            description: "Prolongez votre batterie et maintenez les performances optimales de votre iPhone",
            icon: "BatteriePerformances",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Nouveautés",
            description: "Nouvelles fonctionnalités du dernier IOS",
            icon: "Nouveautés",
            astuces: [],
            topics: []
        )
    ]
    
    init(categories: [Categorie] = []) {
        if !categories.isEmpty {
            self.categories = categories
        }
    }
}
