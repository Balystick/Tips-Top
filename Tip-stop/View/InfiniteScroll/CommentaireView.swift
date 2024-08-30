//
//  CommentaireView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 08/08/2024.
//
import SwiftUI

struct CommentaireView: UIViewControllerRepresentable {
    var commentaires: [Commentaire]

    func makeUIViewController(context: Context) -> CommentaireViewController {
        let viewController = CommentaireViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: CommentaireViewController, context: Context) {
        uiViewController.updateCommentaires(commentaires)
    }
}
