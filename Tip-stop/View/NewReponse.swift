//
//  NewCommentaire.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 05/08/2024.
//

import SwiftUI

struct NewReponse: View {
    
    @State var textCommentaire:String = ""
    var date = Date()
    var user1 = utilisateur1
    var body: some View {
        
        
      ScrollView
        {
            VStack
            {
                Text("Commentaire")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 32))
                    .padding(.trailing,100)
                
                
                ZStack
                {
                    Rectangle()
                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                        .foregroundStyle(.gray)
                        .frame(width: 300,height: 250)
                    
                        
                    TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $textCommentaire)
                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                        .foregroundStyle(.black)
                        .frame(width: 200,height: 250)
                }
               
                
                Button("Ajouter")
                {
                    ReponseView().allReponse.append(Reponse(date: Date(), contenu: textCommentaire, utilisateur: user1))
                }
            }
        }
        
       
    }
    
       
}

#Preview {
    NewReponse()
}
