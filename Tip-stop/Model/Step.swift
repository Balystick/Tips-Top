//
//  Steps.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//

import Foundation

/// Une structure représentant une étape avec des informations détaillées.
///
/// La structure `Step` est utilisée pour modéliser les données d'une étape,
/// incluant un identifiant unique, un titre et une description.
///
/// Conformément au protocole `Identifiable`, chaque étape a un identifiant unique généré automatiquement.
struct Step: Codable {
    
    var id: String
    
    var num : Int
    
    /// Le titre de l'étape.
    var titre: String
    
    /// La description de l'étape.
    var description: String
    
    /// Le sélection du step
    var isSelected : Bool
    
}
