//
//  Topic.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//

import SwiftUI

var utilisateur1 = Utilisateur(nom: "User1", photo: "👩‍✈️")

var rep1 = Reponse(date: Date(), contenu: "Lorem Ipsum", utilisateur:
                    utilisateur1)
var topic1 = Topic(dateDebut: Date(), sujet: "Pourquoi les dauphins volent dans l'eau?  ", reponse: [rep1])

var Thootpick =  TopicViewModel.init(topics: [topic1], reponses: [rep1])

struct TopicView: View {
    var body: some View {
        ScrollView
        {
            VStack(spacing : 20) {
                
                HStack
                {
                    Circle()
                        .frame(width: 50)
                    Text("Animaux")
                }
                
                .padding(.trailing,200)
                
                Text(topic1.sujet)
                    .font(.system(size: 30))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(width: 350)
                    .padding(.trailing)
                Text(rep1.date, format: .dateTime.day().month().year())
                    .font(.system(size: 15))
                    .fontWeight(.ultraLight)
                    .padding(.trailing,200)
            }
            
            VStack
            {
                ReponseView()
            }
            .padding()
        }
    }
}




#Preview {
    TopicView()
}
