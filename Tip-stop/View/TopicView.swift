//
//  Topic.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//

import SwiftUI
import UIKit
var step1 = Step(titre: "", description: "")


var rep1 = Reponse(date: Date(), contenu: """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nunc sit amet nibh malesuada consectetur vitae a nulla. Sed enim ligula, tincidunt vel pharetra venenatis, efficitur sed tortor. Ut varius purus vitae volutpat feugiat. Morbi non magna ut tellus aliquet fringilla. Etiam efficitur lorem sed dolor tristique, sed scelerisque odio faucibus. Duis tristique sed leo et rhoncus. Etiam mattis aliquet lacus eget iaculis
""", utilisateur: utilisateur1)

var categorie1 = Categorie(titre: "Animaux", description: "", icon: "", astuces: [], topics: [])

var topic1 = Topic(dateDebut: Date(), sujet: "", reponse: [], categorie: categorie1)

var astuce = Astuce(titre: "", video: "", dateDeCreation: Date(), pourcentageVue: 0, nombreDeLikes: 0,categorie: Categorie(titre: "", description: "", icon: "", astuces: [], topics: []) ,steps: [], commentaires: [])

var commentaires1 = Commentaire(contenu: "", date: "", nombreDeLikes: 0, utilisateur: utilisateur1)

var favoris = Favori(dateAjout: Date(), astuce: astuce )

var utilisateur1 = Utilisateur(nom: "Piolord", photo: UIImage(named: ""), favoris: [favoris])

struct TopicView: View {
    
    var sujetName = ""
    var userName = ""
    var categorieName = ""
    
    var body: some View {
        NavigationStack
        {
           ZStack
            {
                ScrollView
                {
                    
                    VStack(spacing : 20) {
                        
                        HStack
                        {
                            
                            Text(categorieName)
                            Image("")
                                .resizable()
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .frame(width: 50)
                            
                            Text(userName)
                        }
                        .padding(.trailing)
                        
                        Text(sujetName)
                            .font(.system(size: 25))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(width: 350)
                            .padding(.trailing)
                        Text(rep1.date, format: .dateTime.day().month().year())
                            .font(.system(size: 15))
                            .fontWeight(.ultraLight)
                            .padding(.trailing,200)
                        
                    }
                    ReponseView()
                }
                
                NavigationLink(destination: NewReponse())
                {
                   Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 70,height: 70)
                        .padding(.top,600)
                        .padding(.leading,230)
                        
                }.frame(width: 70,height: 70)
            }
            
            
          
          
        }
        
       
    }
    
}






#Preview {
    TopicView()
}
