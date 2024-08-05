//
//  ImagePicker.swift
//  Tip-stop
//
//  Created by Audrey on 29/07/2024.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var Image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker ) {
            self.parent = parent
        }

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


//Extension with functions to Load and save image from ImagePicker in User Defaults
extension URL {
    func loadImage(_ image: inout UIImage?) {
        if let data = try? Data(contentsOf: self), let loaded = UIImage(data: data) {
            image = loaded
        } else {
            image = nil
        }
    }
    func saveImage(_ image: UIImage?) {
        if let image = image {
            if let data = image.jpegData(compressionQuality: 1.0) {
                try? data.write(to: self)
                UserDefaults.standard.set(data, forKey: "profile")
            }
        } else {
            try? FileManager.default.removeItem(at: self)
        }
    }
}
