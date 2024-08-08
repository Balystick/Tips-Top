//
//  StepsView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 29/07/2024.
//
import SwiftUI

struct StepsView: View {
    
    @State private var isValidate = false
    
    @State private var steps: [Step] = [
        Step(titre: "Ouvrir les réglages", description: ""),
        Step(titre: "Aller dans accessibilité", description: ""),
        Step(titre: "Sélectionner", description: ""),
        Step(titre: "Aller dans", description: ""),
        Step(titre: "Ouvir le lien", description: ""),
        Step(titre: "", description: ""),
        Step(titre: "", description: ""),
        Step(titre: "", description: ""),
        Step(titre: "", description: ""),
        Step(titre: "", description: "")
    ]
    
    var nb = 1
    
    var body: some View {
        NavigationView {
            List(steps) { step in
//                let index = steps.firstIndex(where: {$0.id == step.id})
                VStack {
                    HStack {
                        if isValidate {
                            ZStack{
                                Circle()
                                    .frame(width: 60)
                                    .foregroundColor(.customBlue)
                                    .onTapGesture {
                                        isValidate.toggle()
                                    }
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color(.customLightGray))
                            }
                        }else {
                            ZStack{
                                Circle()
                                    .stroke(Color(.customBlue), lineWidth: 3)
                                    .frame(width: 60)
                                    .font(.title)
                                    .foregroundColor(Color(.white))
                                    .onTapGesture {
                                        isValidate.toggle()
                                    }
                                Text("")
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(Color("customBlue"))
                            }
                        }
                        VStack(alignment: .leading){
                            Text(step.titre)
                            Text(step.description)
                        }
                    }
                }
            }
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color(.white))
            .navigationTitle("Steps")
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Image(systemName: "multiply")
            }))
        }
    }
}
#Preview {
    StepsView()
}
