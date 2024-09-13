//
//  AddTopic.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 13/09/2024.
//

import SwiftUI

struct AddTopic: View {
    
    
    
    @State var sujetText = ""
    var viewModel:TopicViewModel
    //var topic:Topic
    
    var body: some View {
        
        //var topic:Topic
        VStack(alignment:.leading)
        {
            HStack
            {
                TextField("New Topic", text: $sujetText)
                    .frame(width: 200)
                
                        Button(action:
                        {
                            viewModel.topics.append(Topic(dateDebut: Date(), sujet: sujetText, reponse: [], categorie: categorie1))
                   // print(ListTopicView().allTopic[2])
                },
                       label:
                        {
                   ZStack
                    {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 50,height: 50)
                        Text("Send")
                            .foregroundStyle(.white)
                    }
                })
            }
        }
    }
}



