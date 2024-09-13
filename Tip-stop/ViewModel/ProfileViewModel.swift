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
    
    private let baseURL = "http://10.80.55.40:3000/utilisateur"
    
    /// Initialise une nouvelle instance de `ProfileViewModel` avec une liste de favoris et les informations de l'utilisateur.
    ///
    /// - Parameters:
    ///   - favoris: Une liste d'objets de type `Favori`.
    ///   - utilisateur: Un objet de type `Utilisateur` représentant l'utilisateur.
    init(globalDataModel: GlobalDataModel, favoris: [Favori], utilisateur: Utilisateur) {
        self.globalDataModel = globalDataModel
        self.favoris = favoris
        let savedName = UserDefaults.standard.string(forKey: "name") ?? ""
        self.utilisateur = Utilisateur(id: UUID(), nom: savedName, photo: utilisateur.photo, favoris: utilisateur.favoris)
    }
    
    
    private var imageURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("image.jpg")
    }
    
    func saveImage(_ image: UIImage?) {
        guard let image = image, let data = image.jpegData(compressionQuality: 0.8) else { return }
        do {
            try data.write(to: imageURL)
            //            utilisateur.photo = image
        } catch {
            print("Erreur lors de la sauvegarde de l'image: \(error)")
        }
    }
    
    func loadImage() {
        guard let data = try? Data(contentsOf: imageURL) else { return }
        //        utilisateur.photo = UIImage(data: data)
    }
    
    func saveName(_ name: String) {
        UserDefaults.standard.set(name, forKey: "name")
        utilisateur.nom = name
    }
    
    /// Ajoute un nouvel utilisateur avec un nom vide et les mêmes informations de photo que l'utilisateur actuel.
    ///
    /// Cette fonction crée une nouvelle instance de `Utilisateur` avec un nom vide,
    /// la même photo que l'utilisateur actuel et une liste de favoris vide.
    func addUtilisateur() {
        var utilisateur = Utilisateur(id: UUID(), nom: "", photo: utilisateur.photo, favoris: [])
        // Ici, il pourrait y avoir un code pour ajouter cet utilisateur quelque part.
    }
    
    func fetchUtilisateur() {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedUtilisateur = try JSONDecoder().decode(Utilisateur.self, from: data)
                    DispatchQueue.main.async {
                        self.utilisateur = decodedUtilisateur
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
