//
//  ReponseView.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 30/07/2024.
//

import SwiftUI
import UIKit

struct ReponseView: View {
    
    @StateObject var viewModel = TopicViewModel()
    
    var body: some View {
        
        NavigationView
        {
            List(viewModel.reponses) { reponse in
                
                VStack(alignment: .leading, spacing : 20)
                {
                    VStack(spacing: 20) {
                        
                        HStack(spacing :10)
                        {
                            ZStack
                            {
                                Circle()
                                    .frame(width: 50)
                                Image(reponse.utilisateur.photo)
                            }
                            Text(reponse.utilisateur.nom)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .frame(width: 200)
                        
                        
                        .padding(.trailing,230)
                        
                        VStack {
                            Text(reponse.contenu)
                        }
                        .frame(width: 330)
                        //.padding(.leading)
                        
                        
                        ZStack
                        {
                            HStack()
                            {
                                Button{}
                            label:
                                {
                                    Image(systemName: "arrowshape.up")
                                        .foregroundStyle(.black)
                                }
                                
                                Button{}
                            label:
                                {
                                    Image(systemName: "arrowshape.down")
                                        .foregroundStyle(.black)
                                }
                                
                                Text("Repondre")
                                Image(systemName: "arrowshape.turn.up.left")
                                
                            }
                            .frame(width: 200)
                            .padding(.leading,150)
                            
                        }
                    }
                    
                    
                }
            }
            .onAppear{viewModel.fetchReponse()}
            
            NavigationLink(destination: NewReponse(viewModel: viewModel), label:
                            {
                Circle()
                    .frame(width:50)
                    .padding(.leading,200)
            })
        }
        
    }
}





#Preview {
    ReponseView()
}







////
////  ReponseView.swift
////  Tip-stop
////
////  Created by Apprenant 163 on 30/07/2024.
////
//
//import SwiftUI
//import UIKit
//
//struct ReponseView: View {
//
//
//
//    var rep1 = Reponse(id: UUID(), date: Date(), contenu: """
//Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nunc sit amet nibh malesuada consectetur vitae a nulla. Sed enim ligula, tincidunt vel pharetra venenatis, efficitur sed tortor. Ut varius purus vitae volutpat feugiat. Morbi non magna ut tellus aliquet fringilla. Etiam efficitur lorem sed dolor tristique, sed scelerisque odio faucibus. Duis tristique sed leo et rhoncus. Etiam mattis aliquet lacus eget iaculis
//""", utilisateur: utilisateur1)
//
//    @State var allReponse:[Reponse] = [Reponse(id: UUID(), date: Date(), contenu: """
//Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nunc sit amet nibh malesuada consectetur vitae a nulla. Sed enim ligula, tincidunt vel pharetra venenatis, efficitur sed tortor. Ut varius purus vitae volutpat feugiat. Morbi non magna ut tellus aliquet fringilla. Etiam efficitur lorem sed dolor tristique, sed scelerisque odio faucibus. Duis tristique sed leo et rhoncus. Etiam mattis aliquet lacus eget iaculis
//""", utilisateur: utilisateur1),Reponse(id: UUID(), date: Date(), contenu: "Test", utilisateur: utilisateur1)]
//
//    var body: some View {
//
//        ForEach(allReponse)
//        {
//            reponse in /*FormReponseView(imageProfile: utilisateur1.photo ,nameUser: reponse.utilisateur.nom, contenu: reponse.contenu )*/
//        }
//
//
//    }
//}
//
//
//
//struct FormReponseView: View {
//
//    var imageProfile: UIImage?
//    var nameUser:String
//    var contenu:String
//
//
//
//    var body: some View {
//        VStack(alignment: .leading, spacing : 20)
//        {
//            VStack(spacing: 20) {
//
//                HStack(spacing :10)
//                {
//                    ZStack
//                    {
//                        Circle()
//                            .frame(width: 50)
//                           Image("")
//                    }
//                    Text(nameUser)
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//
//
//                }
//                .frame(width: 200)
//
//
//                .padding(.trailing,230)
//
//                VStack {
//                    Text(contenu)
//
//                }
//                .frame(width: 330)
//                    //.padding(.leading)
//
//
//                ZStack
//                {
//                    HStack()
//                    {
//                        Button{}
//                    label:
//                        {
//                            Image(systemName: "arrowshape.up")
//                                .foregroundStyle(.black)
//                        }
//
//                        Button{}
//                    label:
//                        {
//                            Image(systemName: "arrowshape.down")
//                                .foregroundStyle(.black)
//                        }
//                        Text("Repondre")
//                        Image(systemName: "arrowshape.turn.up.left")
//
//                    }
//                    .frame(width: 200)
//                    .padding(.leading,150)
//
//                }
//            }
//
//
//        }
//        .frame(maxHeight: .infinity)
//    }
//}
//
//#Preview {
//    ReponseView()
//}
//
