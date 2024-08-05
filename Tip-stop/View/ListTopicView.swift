//
//  ListTopicView.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 04/08/2024.
//

import SwiftUI

struct ListTopicView: View {
    @State var upVote1 = false
    @State var downVote1 = false
    //
    @State var upVote2 = false
    @State var downVote2 = false
    //
    @State var upVote3 = false
    @State var downVote3 = false
    //
    @State var upVote4 = false
    @State var downVote4 = false
    //
    @State var user1 = "R6y"
    @State var user2 = "FlippersDesMers"
    @State var user3 = "BunnyBugs34"
    @State var user4 = ""
    //
    @State var sujet1 = "Les androïdes rêvent-ils de moutons électriques ?"
    @State var sujet2 = "Les dauphins volent-ils dans l'eau"
    @State var sujet3 = "Une carrote dans la terre est-elle une carrote qui ce noit ?"
    //
    @State private var navigationLinkIsActive = false
    
    
    
    @State var allTopic:[Topic] = [
        Topic(dateDebut: Date(), sujet: "Les androïdes rêvent-ils de moutons électriques ?", reponse: [rep1]),
        Topic(dateDebut: Date(), sujet: "Les dauphins volent-ils dans l'eau", reponse: [rep1]),
        Topic(dateDebut: Date(), sujet: "Une carrote dans la terre est-elle une carrote qui ce noit ?", reponse: [rep1])
        
    ]
    
    
    var body: some View
    {
        NavigationStack
        {
            List
            {
                NavigationLink(destination: TopicView(sujetName: sujet1,userName: user1))
                {
                    
                 cellListTopic(upVote: $upVote1, downVote: $downVote1, nameUser: $user1, nameSujet: $sujet1)
                }
                //
                NavigationLink(destination: TopicView(sujetName: sujet2))
                {
                    
                 cellListTopic(upVote: $upVote2, downVote: $downVote2, nameUser: $user2, nameSujet: $sujet2)
                }
                //
                NavigationLink(destination: TopicView(sujetName: sujet3))
                {
                    
                 cellListTopic(upVote: $upVote3, downVote: $downVote3, nameUser: $user3, nameSujet: $sujet3)
                }
                cellListTopic(upVote: $upVote4, downVote: $downVote4, nameUser: $user1, nameSujet: $sujet1)
            
            }
        }
    }
}



struct cellListTopic: View {
    @Binding var upVote:Bool
    @Binding var downVote:Bool
    @Binding var nameUser:String
    @Binding var nameSujet:String
    var body: some View
    {
        ZStack
        {
            VStack(alignment: .leading,spacing: 7)
            {
               HStack
                {
                    Circle()
                        .frame(width: 30)
                    Text(nameUser)
                        .font(.system(size: 13))
                        
                }
                Text(nameSujet)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)

                HStack
                {
                    Button
                    {
                        upVote.toggle()
                    }
                label:
                    {
                        if upVote
                        {
                            Image(systemName: "arrowshape.up.fill")
                                .foregroundStyle(.red)
                        }
                        else
                        {
                            Image(systemName: "arrowshape.up")
                                .foregroundStyle(.black)
                        }
                           
                    }
                    
                        Button
                        {
                            downVote.toggle()
                        }
                    label:
                    {
                        
                        if downVote
                        {
                            Image(systemName: "arrowshape.down.fill")
                                .foregroundStyle(.blue)
                        }
                        else
                        {
                            Image(systemName: "arrowshape.down")
                                .foregroundStyle(.black)
                        }
                    }
                       }
                  
                    
                }
                //.padding(.trailing)
                //
                
            }
            
           
            
            
        }
    }





#Preview {
    ListTopicView()
}
