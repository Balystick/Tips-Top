//
//  Steps.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    var titre: String
    var description: [String]
    var astuce: Astuce
}
