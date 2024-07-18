//
//  InfiniteScrollViewModel.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//

import Foundation

class InfiniteScrollViewModel {
    @Published var astuces: [Astuce] = []
    @Published var commentaires: [Commentaire] = []
    @Published var steps: [Step] = []
    
    init(astuces: [Astuce], commentaires: [Commentaire], steps: [Step]) {
        self.astuces = astuces
        self.commentaires = commentaires
        self.steps = steps
    }
}
