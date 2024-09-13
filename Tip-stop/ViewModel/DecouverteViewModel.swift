//
//  Untitled.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

class DecouverteViewModel:ObservableObject {
    @Published var categories: [Categorie] = []
    @Published var topics: [Topic] = []
    
    init(categories: [Categorie], topics: [Topic]) {
        self.categories = categories
        self.topics = topics
    }
}
