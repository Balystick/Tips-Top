//
//  ListTopicView.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 04/08/2024.
//

import SwiftUI
import UIKit

struct ListTopicView: View{
    
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
            NavigationStack
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
    ListTopicView()
}
