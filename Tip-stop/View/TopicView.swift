//
//  Topic.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//

import SwiftUI

var step1 = Step(titre: "", description: "")


var rep1 = Reponse(date: Date(), contenu: """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nunc sit amet nibh malesuada consectetur vitae a nulla. Sed enim ligula, tincidunt vel pharetra venenatis, efficitur sed tortor. Ut varius purus vitae volutpat feugiat. Morbi non magna ut tellus aliquet fringilla. Etiam efficitur lorem sed dolor tristique, sed scelerisque odio faucibus. Duis tristique sed leo et rhoncus. Etiam mattis aliquet lacus eget iaculis
""", utilisateur: utilisateur1)


var astuce = Astuce(titre: "", video: "", dateDeCreation: Date(), pourcentageVue: 0, nombreDeLikes: 0, steps: [], commentaires: [])

var commentaires1 = Commentaire(contenu: "", date: "", nombreDeLikes: 0, utilisateur: utilisateur1)
var favoris = Favori(dateAjout: Date(), astuce: astuce )

var categorie1 = Categorie(titre: "", description: "", icon: "", astuces: [], topics: [])

var topic1 = Topic(dateDebut: Date(), sujet: "", reponse: [], categorie: categorie1)




var utilisateur1 = Utilisateur(nom: "", photo: "", favoris: [favoris])

struct TopicView: View {
    
    var sujetName = ""
    var userName = ""
    var categorieName = ""
    
    var body: some View {
        VStack(spacing : 20) {
            
            HStack
            {
                
                Text("NameCategorie \(categorieName)")
                Image("")
                    .resizable()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: 50)
                
                
                Text(userName)
            }
            
            .padding(.trailing,200)
            
            Text(sujetName)
                .font(.system(size: 30))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .frame(width: 350)
                .padding(.trailing)
            Text(rep1.date, format: .dateTime.day().month().year())
                .font(.system(size: 15))
                .fontWeight(.ultraLight)
                .padding(.trailing,200)
        }
        
        
        ReponseView()
        
        ZStack {
            VStack
            {
                    ReponseView()
                    
            }
        .padding()
            
                NavigationLink(destination :NewCommentaire())
                {
                    Image(systemName: "plus.message.fill")
                        .resizable()
                        .frame(width: 50,height: 50)
                        .padding(.leading,300)
                        .padding(.top,200)
                }
                
            }
            
            
        }
        
    }






#Preview {
    TopicView()
}
