//
//  ImagePicker.swift
//  Tip-stop
//
//  Created by Audrey on 29/07/2024.
//

import Foundation
import SwiftUI
import UIKit
/// Une structure représentant un sélecteur d'images intégré dans SwiftUI.
///
/// La structure `ImagePicker` permet d'utiliser un sélecteur d'images (`UIImagePickerController`),
/// offrant une interface pour sélectionner une image depuis la bibliothèque photo ou la caméra.
/// Elle conforme au protocole `UIViewControllerRepresentable`, permettant son intégration dans une vue SwiftUI.
///
/// - Note: Utilisez cette struct pour permettre aux utilisateurs de choisir une image dans une vue SwiftUI.
struct ImagePicker: UIViewControllerRepresentable {
    
    /// L'environnement de présentation pour gérer la fermeture du sélecteur d'images.
    @Environment(\.presentationMode) private var presentationMode
    
    /// Le type de source pour le sélecteur d'images, par défaut la bibliothèque photo.
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    /// La liaison à l'image sélectionnée.
    @Binding var Image: UIImage?

    /// Crée et configure le contrôleur de sélecteur d'images.
    ///
    /// - Parameter context: Le contexte dans lequel le contrôleur est créé.
    /// - Returns: Un `UIImagePickerController` configuré.
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    /// Met à jour le contrôleur de sélecteur d'images. Cette fonction est appelée lorsque la vue SwiftUI est actualisée.
    ///
    /// - Parameters:
    ///   - uiViewController: Le contrôleur de sélecteur d'images à mettre à jour.
    ///   - context: Le contexte dans lequel le contrôleur est mis à jour.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    /// Crée le coordinateur pour gérer les actions du sélecteur d'images.
    ///
    /// - Returns: Un coordinateur `Coordinator` pour gérer les délégués du sélecteur d'images.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    /// Un coordinateur pour gérer les événements du sélecteur d'images.
    ///
    /// Le coordinateur est responsable de la gestion des délégués `UIImagePickerControllerDelegate`
    /// et `UINavigationControllerDelegate`, notamment la gestion de l'image sélectionnée.
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker ) {
            self.parent = parent
        }

        /// Appelé lorsque l'utilisateur sélectionne une image ou annule la sélection.
        ///
        /// - Parameters:
        ///   - picker: Le sélecteur d'images qui a terminé.
        ///   - info: Un dictionnaire contenant les informations sur l'image sélectionnée.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.Image = image
            }

            parent.presentationMode.wrappedValue.dismiss()
            
            guard let imageUrl = info[.imageURL] as? URL else {
                return
            }
            
            do {
                let tempDirectory = URL(fileURLWithPath: NSTemporaryDirectory())
                    .appendingPathComponent("uploads")
                try FileManager.default.createDirectory(at: tempDirectory, withIntermediateDirectories: true, attributes: nil)

                let fileURL = tempDirectory
                    .appendingPathComponent(UUID().uuidString)
                try FileManager.default.copyItem(at: imageUrl, to: fileURL)

                try FileManager.default.removeItem(at: fileURL)
            } catch {
                print(error)
            }
        }

    }
}

/// Extension pour charger et enregistrer des images depuis et vers les User Defaults.
///
/// Cette extension ajoute des fonctions à `URL` pour faciliter le chargement et l'enregistrement
/// d'images dans les User Defaults.
extension URL {
    /// Charge une image depuis l'URL et la stocke dans la variable fournie.
    ///
    /// - Parameter image: Une variable `UIImage?` où l'image chargée sera stockée.
    func loadImage(_ image: inout UIImage?) {
        if let data = try? Data(contentsOf: self), let loaded = UIImage(data: data) {
            image = loaded
        } else {
            image = nil
        }
    }
    
    /// Enregistre une image à l'URL spécifiée et met à jour les User Defaults.
    ///
    /// - Parameter image: L'image `UIImage?` à enregistrer. Si `nil`, l'image sera supprimée de l'URL.
    func saveImage(_ image: UIImage?) {
        if let image = image {
            if let data = image.jpegData(compressionQuality: 1.0) {
                try? data.write(to: self)
                UserDefaults.standard.set(data, forKey: "profile")
                UserDefaults.standard.data(forKey: "profile")
            }
        } else {
            try? FileManager.default.removeItem(at: self)
        }
    }
}
