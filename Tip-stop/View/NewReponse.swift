//
//  NewCommentaire.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 05/08/2024.
//

import SwiftUI
import UIKit

struct NewReponse: UIViewControllerRepresentable {
    
    @State var textCommentaire:String = ""
    var date = Date()
    var user1 = utilisateur1
    
        func makeUIViewController(context: Context) -> NewReponseController
        {
            guard let finalVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "NewReponseController")as? NewReponseController
            else
            {
                fatalError("Unable to Instantiate Detail View Controller")
            }
            return finalVC
        }
        
    
        func updateUIViewController(_ viewController: NewReponseController,context: Context)
        {
            
        }
}

#Preview {
    NewReponse()
}
