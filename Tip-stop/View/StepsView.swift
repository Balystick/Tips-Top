//
//  StepsView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 29/07/2024.
//
import SwiftUI

struct StepsView: View {
    let steps: [Step]
    
    var body: some View {
        NavigationView {
            List(steps) { step in
                VStack(alignment: .leading) {
                    Text(step.titre)
                        .font(.headline)
                    Text(step.description)
                        .font(.subheadline)
                }
                .padding()
            }
            .navigationTitle("Steps")
            .navigationBarItems(trailing: Button("Close") {
                
            })
        }
    }
}
