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
    
   @State var upVote = false
    @State var downVote = false
    @State var imageUpVote:Image =  Image(systemName: "arrowshape.up")
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
                        Text(rep1.utilisateur.photo)
                            .font(.system(size: 40))
                    }
                    Text(rep1.utilisateur.nom)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .padding(.trailing,250)
                
                Text(rep1.contenu)
                    .frame(width: 350)
                
                ZStack
                {
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
                        Text("Repondre")
                        Image(systemName: "arrowshape.turn.up.left")
                        
                    }
                    
                }.padding(.trailing,200)
            }
            //Copie 1 de rep1
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
                        Text(rep1.utilisateur.photo)
                            .font(.system(size: 40))
                    }
                    Text(rep1.utilisateur.nom)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .padding(.trailing,250)
                
                Text(rep1.contenu)
                    .frame(width: 350)
                
                ZStack
                {
                    HStack
                    {
                        Image(systemName: "arrowshape.up")
                        Image(systemName: "arrowshape.down")
                        Text("Repondre")
                        Image(systemName: "arrowshape.turn.up.left")
                        
                        
                    }
                    
                }.padding(.trailing,200)
            }
            //Copie 2 de rep1
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
                        Text(rep1.utilisateur.photo)
                            .font(.system(size: 40))
                    }
                    Text(rep1.utilisateur.nom)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .padding(.trailing,250)
                
                Text(rep1.contenu)
                    .frame(width: 350)
                
                ZStack
                {
                    HStack
                    {
                        Image(systemName: "arrowshape.up")
                        Image(systemName: "arrowshape.down")
                        Text("Repondre")
                        Image(systemName: "arrowshape.turn.up.left")
                        
                        
                    }
                    
                }.padding(.trailing,200)
            }
            
        }
    }
}

#Preview {
    ReponseView()
}

