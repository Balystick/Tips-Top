//
//  GlobalDataModel.swift
//  Tip-stop
//
//  Created by Aurélien on 07/08/2024.
//

import SwiftUI
import Combine

/// `GlobalDataModel`  gère les catégories de l'application, les profils des utilisateurs, et recommande des vidéos en fonction des interactions des utilisateurs.
///
/// Cette classe utilise `UserDefaults` pour stocker et récupérer le profil utilisateur et l'historique des vidéos vues.
class GlobalViewModel: ObservableObject {
    static let shared = GlobalViewModel()

    let baseURL = "http://localhost:3000/"
    let baseVideoURL = "https://www.balystick.fr/tipstop/"

    // Les catégories de fonctionnalités disponibles dans l'application.
    var categories: [Categorie] = []
    
    func fetchCategories() {
        guard let url = URL(string: baseURL + "categories") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedCategories = try JSONDecoder().decode([Categorie].self, from: data)
                    DispatchQueue.main.async {
                        self.categories = decodedCategories
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
}

