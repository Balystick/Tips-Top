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
    
    private let utilisateurService = UtilisateurService() // Utilisation du service
    
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
    /// Ajoute un nouvel utilisateur avec un nom vide et les mêmes informations de photo que l'utilisateur actuel.
       ///
       /// Cette fonction crée une nouvelle instance de `Utilisateur` avec un nom vide,
       /// la même photo que l'utilisateur actuel et une liste de favoris vide.
    func addUtilisateur() {
        var utilisateur = Utilisateur(id: UUID(), nom: "", photo: utilisateur.photo, favoris: [])
        // Ici, il pourrait y avoir un code pour ajouter cet utilisateur quelque part.
    }
    /// Sauvegarde le nom de l'utilisateur dans `UserDefaults`.
    func saveName(_ name: String) {
        UserDefaults.standard.set(name, forKey: "name")
        utilisateur.nom = name
    }
    
    /// Récupère les informations de l'utilisateur depuis l'API.
    func fetchUtilisateur() {
        utilisateurService.fetchUtilisateur { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let utilisateur):
                    self.utilisateur = utilisateur
                case .failure(let error):
                    print("Error fetching utilisateur: \(error)")
                }
            }
        }
    }
}



