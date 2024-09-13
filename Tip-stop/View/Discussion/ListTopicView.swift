//
//  ListTopicView.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 04/08/2024.
//

import SwiftUI
import UIKit

struct ListTopicView: View{
    @Binding var path: NavigationPath
    @StateObject private var viewModel = TopicViewModel()
    
    
    /*
     [Topic(dateDebut: Date(), sujet: "Les androïdes rêvent-ils de moutons électriques ?", reponse: [rep1], categorie: categorie1),
     Topic(dateDebut: Date(), sujet: "Les dauphins volent-ils dans l'eau", reponse: [rep1], categorie: categorie1),
     Topic(dateDebut: Date(), sujet: "Une carrote dans la terre est-elle une carrote qui ce noit ?", reponse: [rep1], categorie: categorie1)]
     */
     
    var body: some View
    {
        VStack
        {
            NavigationView
            {
                List(viewModel.topics)
                {
                    topic in NavigationLink(destination: TopicView(viewModel: viewModel,topic: topic))
                    {
                        Text(topic.sujet)
                        
                        
                    }
                    .navigationTitle("List of topics")
                }.onAppear{viewModel.fetchTopics()}
                
                
                
                
                    NavigationLink(destination: AddTopic(viewModel: viewModel), label:{
                        ZStack(alignment:.trailing)
                        {
                            Circle()
                                .frame(width:50)
                        }.padding(.leading,200)
                        
                        
                    })
                }
            
        }
        
        
    }
    
}










#Preview {
    ListTopicView(path: .constant(NavigationPath()))
}








////
////  ListTopicView.swift
////  Tip-stop
////
////  Created by Apprenant 163 on 04/08/2024.
////
//
//import SwiftUI
//import UIKit
//
//struct ListTopicView: View {
//    
//    // Ajout navigation path & globalDataModel
//    @Binding var path: NavigationPath
//    
//    var allTopic:[Topic] = [
//        Topic(id: UUID(), dateDebut: Date(), sujet: "Les androïdes rêvent-ils de moutons électriques ?", reponse: [rep1], categorie: categorie1),
//        Topic(id: UUID(), dateDebut: Date(), sujet: "Les dauphins volent-ils dans l'eau", reponse: [rep1], categorie: categorie1),
//        Topic(id: UUID(), dateDebut: Date(), sujet: "Une carrote dans la terre est-elle une carrote qui ce noit ?", reponse: [rep1], categorie: categorie1)]
//        
//        var body: some View
//        {
//            NavigationView
//            {
//                List(allTopic)
//                {
//                   
//                    topic in NavigationLink(destination: TopicView(sujetName: topic.sujet, categorieName: topic.categorie.titre))
//                    {
//                        Text(topic.sujet)
//                    }
//                }
//    
//            }
//            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        path.removeLast()
//                    }) {
//                        Image(systemName: "arrow.uturn.left")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 35, height: 35)
//                            .foregroundColor(Color(white: 0.2))
//                    }
//                }
//            }
//           
//        }
//    
//}
//
//
//
//
//
//
//
//
//
//
//
//#Preview {
//    ListTopicView(path: .constant(NavigationPath()))
//}
//
