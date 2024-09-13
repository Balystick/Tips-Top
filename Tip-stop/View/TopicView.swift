//
//  Topic.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//

import SwiftUI
import Foundation
import UIKit

struct TopicView: View {
  
    
    @StateObject var viewModel:TopicViewModel
    var topic:Topic
         
    var body: some View {
        
            
            
           VStack
        {
            
            Text(topic.sujet)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .font(.system(size: 86))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
           
            ReponseView()
           
         }
        
                
            
            
            
            
            /*NavigationLink(destination: NewReponse())
             {
             Image(systemName: "plus.circle.fill")
             .resizable()
             .frame(width: 70,height: 70)
             .padding(.top,600)
             .padding(.leading,230)
             
             }.frame(width: 70,height: 70)*/
        
    }
}


