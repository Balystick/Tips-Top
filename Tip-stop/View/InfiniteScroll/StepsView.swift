//
//  StepsView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 29/07/2024.
//
import SwiftUI

struct StepsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isValidate = false
    @State private var steps: [Step] = [
        Step(id: UUID(), num: 1, titre: "Ouvrir Réglages", description: "", isSelected: false),
        Step(id: UUID(), num: 2, titre: "Accéder à Général", description: "", isSelected: false),
        Step(id: UUID(), num: 3, titre: "Sélectionner VPN", description: "", isSelected: false),
        Step(id: UUID(), num: 4, titre: "Ajouter Configuration", description: "", isSelected: false),
        Step(id: UUID(), num: 5, titre: "Choisir Type VPN", description: "", isSelected: false),
        Step(id: UUID(), num: 6, titre: "Entrer Détails Serveur", description: "", isSelected: false),
        Step(id: UUID(), num: 7, titre: "Entrer Identifiants", description: "", isSelected: false),
        Step(id: UUID(), num: 8, titre: "Enregistrer Configuration", description: "", isSelected: false),
        Step(id: UUID(), num: 9, titre: "Activer VPN", description: "", isSelected: false),
        Step(id: UUID(), num: 10, titre: "Vérifier Connexion", description: "", isSelected: false)
    ]
    
    var body: some View {
        VStack {
            HStack{
                Text("Steps")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                Button(action: {dismiss() },
                       label: {Image(systemName: "multiply")
                })
                .font(.title)
                .padding()
            }
            .padding(.horizontal, 10)
            
            ForEach(steps.indices, id: \.self) { index in
                VStack {
                    HStack {
                        ZStack{
                            Circle()
                                .frame(width: 50)
                                .foregroundColor(steps[index].isSelected ? .customBlue : .white)
                                .overlay(
                                    Circle().stroke(Color.customBlue, lineWidth: 3)
                                )
                                .onTapGesture {
                                    if steps[index].isSelected {
                                        if steps[index + 1].isSelected == false {
                                            for i in 0..<steps.count {
                                                steps[i].isSelected = false
                                            }
                                        } else{
                                            for i in index + 1..<steps.count {
                                                if steps[i].isSelected == true {
                                                    steps[i].isSelected.toggle()
                                                }
                                            }
                                        }
                                    }else {
                                        for i in 0...index {
                                            if steps[i].isSelected == false {
                                                steps[i].isSelected.toggle()
                                            }
                                        }
                                    }
//                                    steps[index].isSelected.toggle()
                                }
                            
                            if steps[index].isSelected {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.customLightGray)
                                
                            } else if steps[index].isSelected {
                                
                            }else {
                                Text("\(steps[index].num)")
                                    .foregroundColor(.customBlue)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        if steps[index].isSelected {
                            VStack(alignment: .leading) {
                                Text(steps[index].titre)
                                    .foregroundColor(.customMediumGray)
                                Text(steps[index].description)
                                    .foregroundColor(.customMediumGray)
                            }
                        }else {
                            VStack(alignment: .leading) {
                                Text(steps[index].titre)
                                    .foregroundColor(.black)
                                Text(steps[index].description)
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .padding()
    }
}

#Preview {
    StepsView()
}
