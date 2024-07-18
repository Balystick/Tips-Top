//
//  TopicViewModel.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

class TopicViewModel {
    @Published var topics: [Topic] = []
    @Published var reponses: [Reponse] = []
    
    init(topics: [Topic], reponses: [Reponse]) {
        self.topics = topics
        self.reponses = reponses
    }
}
