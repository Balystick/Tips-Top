//
//  ListTopicView.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 04/08/2024.
//

import SwiftUI
import UIKit

struct ListTopicView: View {
    
    // Ajout navigation path & globalDataModel
    @Binding var path: NavigationPath
    @ObservedObject var globalDataModel: GlobalDataModel
    
    init(path: Binding<NavigationPath>, globalDataModel: GlobalDataModel) {
        self._path = path
        self.globalDataModel = globalDataModel
    }
    
    var allTopic:[Topic] = [
        Topic(dateDebut: Date(), sujet: "Les androïdes rêvent-ils de moutons électriques ?", reponse: [rep1], categorie: categorie1),
        Topic(dateDebut: Date(), sujet: "Les dauphins volent-ils dans l'eau", reponse: [rep1], categorie: categorie1),
        Topic(dateDebut: Date(), sujet: "Une carrote dans la terre est-elle une carrote qui ce noit ?", reponse: [rep1], categorie: categorie1)]
        
        var body: some View
        {
            NavigationView
            {
                List(allTopic)
                {
                   
                    topic in NavigationLink(destination: TopicView(sujetName: topic.sujet, categorieName: topic.categorie.titre))
                    {
                        Text(topic.sujet)
                    }
                }
    
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        path.removeLast()
                    }) {
                        Image(systemName: "arrow.uturn.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color(white: 0.2))
                    }
                }
            }
           
        }
    
}











#Preview {
    ListTopicView(path: .constant(NavigationPath()), globalDataModel: GlobalDataModel())
}

