//
//  Topic.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//

import SwiftUI
import Foundation
import UIKit

struct TopicView: View {
  
    
    @StateObject var viewModel:TopicViewModel
    var topic:Topic
         
    var body: some View {
        
            
            
           VStack
        {
            
            Text(topic.sujet)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .font(.system(size: 86))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
           
            ReponseView()
           
         }
        
                
            
            
            
            
            /*NavigationLink(destination: NewReponse())
             {
             Image(systemName: "plus.circle.fill")
             .resizable()
             .frame(width: 70,height: 70)
             .padding(.top,600)
             .padding(.leading,230)
             
             }.frame(width: 70,height: 70)*/
        
    }
}









////
////  Topic.swift
////  Tip-stop
////
////  Created by Apprenant 122 on 18/07/2024.
////
//
//import SwiftUI
//import UIKit
//var step1 = Step(id: UUID(), num: 0, titre: "", description: "", isSelected: false)
//
//
//var rep1 = Reponse(id: UUID(), date: Date(), contenu: """
//Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nunc sit amet nibh malesuada consectetur vitae a nulla. Sed enim ligula, tincidunt vel pharetra venenatis, efficitur sed tortor. Ut varius purus vitae volutpat feugiat. Morbi non magna ut tellus aliquet fringilla. Etiam efficitur lorem sed dolor tristique, sed scelerisque odio faucibus. Duis tristique sed leo et rhoncus. Etiam mattis aliquet lacus eget iaculis
//""", utilisateur: utilisateur1)
//
//var categorie1 = Categorie(id: UUID(), titre: "Animaux", description: "", icon: "", astuces: [], topics: [])
//
//var topic1 = Topic(id: UUID(), dateDebut: Date(), sujet: "", reponse: [], categorie: categorie1)
//
//var astuce = Astuce(id: UUID(), titre: "", video: "", dateDeCreation: Date(), pourcentageVue: 0, nombreDeLikes: 0,categorie: Categorie(id: UUID(), titre: "", description: "", icon: "", astuces: [], topics: []) ,steps: [], commentaires: [])
//
//var commentaires1 = Commentaire(id: UUID(), contenu: "", date: "", nombreDeLikes: 0, utilisateur: utilisateur1)
//
//var favoris = Favori(id: UUID(), dateAjout: Date(), astuce: astuce )
//
////var utilisateur1 = Utilisateur(id: UUID(), nom: "Piolord", photo: UIImage(named: ""), favoris: [favoris])
//var utilisateur1 = Utilisateur(id: UUID(), nom: "Piolord", photo: "", favoris: [favoris])
//
//struct TopicView: View {
//    
//    var sujetName = ""
//    var userName = ""
//    var categorieName = ""
//    
//    var body: some View {
//        NavigationView
//        {
//           ZStack
//            {
//                ScrollView
//                {
//                    
//                    VStack(spacing : 20) {
//                        
//                        HStack
//                        {
//                            
//                            Text(categorieName)
//                            Image("")
//                                .resizable()
//                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                                .frame(width: 50)
//                            
//                            Text(userName)
//                        }
//                        .padding(.trailing)
//                        
//                        Text(sujetName)
//                            .font(.system(size: 25))
//                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                            .frame(width: 350)
//                            .padding(.trailing)
//                        Text(rep1.date, format: .dateTime.day().month().year())
//                            .font(.system(size: 15))
//                            .fontWeight(.ultraLight)
//                            .padding(.trailing,200)
//                        
//                    }
//                    ReponseView()
//                }
//                
//                NavigationLink(destination: NewReponse())
//                {
//                   Image(systemName: "plus.circle.fill")
//                        .resizable()
//                        .frame(width: 70,height: 70)
//                        .padding(.top,600)
//                        .padding(.leading,230)
//                        
//                }.frame(width: 70,height: 70)
//            }
//            
//            
//          
//          
//        }
//        
//       
//    }
//    
//}
//
//
//
//
//
//
//#Preview {
//    TopicView()
//}
