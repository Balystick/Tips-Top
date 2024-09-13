//
//  NewCommentaire.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 05/08/2024.
//

import SwiftUI
import UIKit

struct NewReponse: View {
    
    @StateObject var viewModel:TopicViewModel
    @State var reponseText:String = ""
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
           HStack
            {
                TextField("new reponse",text: $reponseText)
                    .frame(width: 200,height: 100)
                
                Button(action: {
//                    viewModel.reponses.append(Reponse(date: Date(), contenu: reponseText, utilisateur: utilisateur1))
                }, label:
                        {
                    ZStack
                     {
                         RoundedRectangle(cornerRadius: 10)
                             .frame(width: 75,height: 50)
                         Text("Send")
                             .foregroundStyle(.white)
                     }
                })
            }
            
        }
    }
    
     
}

/*#Preview {
    NewReponse()
}*/






////
////  NewCommentaire.swift
////  Tip-stop
////
////  Created by Apprenant 163 on 05/08/2024.
////
//
//import SwiftUI
//import UIKit
//
//struct NewReponse: UIViewControllerRepresentable {
//    
//    @State var textCommentaire:String = ""
//    var date = Date()
//    var user1 = utilisateur1
//    
//        func makeUIViewController(context: Context) -> NewReponseController
//        {
//            guard let finalVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "NewReponseController")as? NewReponseController
//            else
//            {
//                fatalError("Unable to Instantiate Detail View Controller")
//            }
//            return finalVC
//        }
//        
//    
//        func updateUIViewController(_ viewController: NewReponseController,context: Context)
//        {
//            
//        }
//}
//
//#Preview {
//    NewReponse()
//}
