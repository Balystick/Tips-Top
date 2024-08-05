//
//  ReponseView.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 30/07/2024.
//

import SwiftUI

struct ReponseView: View {
    
    
    
    var rep1 = Reponse(date: Date(), contenu: """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nunc sit amet nibh malesuada consectetur vitae a nulla. Sed enim ligula, tincidunt vel pharetra venenatis, efficitur sed tortor. Ut varius purus vitae volutpat feugiat. Morbi non magna ut tellus aliquet fringilla. Etiam efficitur lorem sed dolor tristique, sed scelerisque odio faucibus. Duis tristique sed leo et rhoncus. Etiam mattis aliquet lacus eget iaculis
""", utilisateur: utilisateur1)
    
    @State var allReponse:[Reponse] = [Reponse(date: Date(), contenu: """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nunc sit amet nibh malesuada consectetur vitae a nulla. Sed enim ligula, tincidunt vel pharetra venenatis, efficitur sed tortor. Ut varius purus vitae volutpat feugiat. Morbi non magna ut tellus aliquet fringilla. Etiam efficitur lorem sed dolor tristique, sed scelerisque odio faucibus. Duis tristique sed leo et rhoncus. Etiam mattis aliquet lacus eget iaculis
""", utilisateur: utilisateur1)]
    
    var body: some View {
        
      
        
        Text("")
        List(allReponse)
        {
            reponse in FormReponseView(imageProfile: utilisateur1.photo ,nameUser: reponse.utilisateur.nom, contenu: reponse.contenu )
        }
    }
}



struct FormReponseView: View {
    
     var imageProfile:String
     var nameUser:String
     var contenu:String
    
    

    var body: some View {
         VStack(spacing : 20)
         {
             VStack(spacing: 20) {
                 Rectangle()
                     .frame(width: 400,height: 10)
                     .foregroundStyle(.gray)
                 HStack
                 {
                     ZStack
                     {
                         Circle()
                             .frame(width: 50)
                         Text(imageProfile)
                             .font(.system(size: 40))
                     }
                     Text(nameUser)
                         .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                 }
                 .padding(.trailing,250)
                 
                 Text(contenu)
                     .frame(width: 350)
                 
                 ZStack
                 {
                     HStack
                     {
                         Button
                         {
                             
                         }
                     label:
                         {
                            
                                 Image(systemName: "arrowshape.up.fill")
                                     .foregroundStyle(.red)
                            
                                 Image(systemName: "arrowshape.up")
                                     .foregroundStyle(.black)
                            
                         }
                         
                         
                         
                         Button
                         {
                             
                         }
                     label:
                         {
                            
                             
                                 Image(systemName: "arrowshape.down.fill")
                                     .foregroundStyle(.blue)
                           
                            
                                 Image(systemName: "arrowshape.down")
                                     .foregroundStyle(.black)
                            
                         }
                         Text("Repondre")
                         Image(systemName: "arrowshape.turn.up.left")
                         
                     }
                     
                 }.padding(.leading,200)
             }
            
             
         }
    }
}

#Preview {
    ReponseView()
}

