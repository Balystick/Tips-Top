//
//  ListTopicView.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 04/08/2024.
//

import SwiftUI
import UIKit

struct ListTopicView: View {
    
    var allTopic:[Topic] = [
        Topic(dateDebut: Date(), sujet: "Les androïdes rêvent-ils de moutons électriques ?", reponse: [rep1], categorie: categorie1),
        Topic(dateDebut: Date(), sujet: "Les dauphins volent-ils dans l'eau", reponse: [rep1], categorie: categorie1),
        Topic(dateDebut: Date(), sujet: "Une carrote dans la terre est-elle une carrote qui ce noit ?", reponse: [rep1], categorie: categorie1)]
        
        var body: some View
        {
            NavigationStack
            {
                List(allTopic)
                {
                   
                    topic in NavigationLink(destination: TopicView(sujetName: topic.sujet, categorieName: topic.categorie.titre))
                    {
                        Text(topic.sujet)
                    }
                }
    
            }
           
        }
    
}










#Preview {
    ListTopicView()
}
