//
//  UtilisateurServiceModel.swift
//  Tip-stop
//
//  Created by Audrey on 13/09/2024.
//

import Foundation

/// Classe responsable de la gestion des requêtes réseau pour les utilisateurs.
class UtilisateurService {
    private let baseURL = "http://localhost:3000/utilisateur"
    
    /// Récupère un utilisateur depuis l'API.
    ///
    /// - Parameter completion: Un closure qui sera appelé une fois l'utilisateur récupéré, ou une erreur en cas d'échec.
    func fetchUtilisateur(completion: @escaping (Result<Utilisateur, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let utilisateur = try JSONDecoder().decode(Utilisateur.self, from: data)
                completion(.success(utilisateur))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
