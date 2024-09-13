//
//  ReponseView.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 30/07/2024.
//

import SwiftUI
import UIKit

struct ReponseView: View {
    
    @StateObject  var viewModel = TopicViewModel()
    
    
   
    
    var body: some View {
        
      NavigationStack
        {
            List(viewModel.reponses) { reponse in
                
                VStack(alignment: .leading, spacing : 20)
                {
                    VStack(spacing: 20) {

                        HStack(spacing :10)
                        {
                            ZStack
                            {
                                Circle()
                                    .frame(width: 50)
                                Image(reponse.utilisateur.photo)
                            }
                            Text(reponse.utilisateur.nom)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .frame(width: 200)
                       
                        
                        .padding(.trailing,230)
                        
                        VStack {
                            Text(reponse.contenu)
                        }
                        .frame(width: 330)
                            //.padding(.leading)
                            
                        
                        ZStack
                        {
                            HStack()
                            {
                                Button{}
                            label:
                                {
                                    Image(systemName: "arrowshape.up")
                                        .foregroundStyle(.black)
                                }
                                
                                Button{}
                            label:
                                {
                                    Image(systemName: "arrowshape.down")
                                        .foregroundStyle(.black)
                                }
                                
                                Text("Repondre")
                                Image(systemName: "arrowshape.turn.up.left")
                                
                            }
                            .frame(width: 200)
                            .padding(.leading,150)
                            
                        }
                    }
                    
                    
                }
            }
            .onAppear{viewModel.fetchReponse()}
            
            NavigationLink(destination: NewReponse(viewModel: viewModel), label:
                            {
                Circle()
                    .frame(width:50)
                    .padding(.leading,200)
            })
        }
        
    }
}





#Preview {
    ReponseView()
}

