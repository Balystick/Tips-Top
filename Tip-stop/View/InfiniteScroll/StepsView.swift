//
//  StepsView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 29/07/2024.
//
import SwiftUI

struct StepsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var steps: [Step]  // Receive steps as a binding

    var body: some View {
        VStack {
            HStack {
                Text("Steps")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { dismiss() },
                       label: { Image(systemName: "multiply") })
                    .font(.title)
                    .padding()
            }
            .padding(.horizontal, 10)
            
            ForEach(steps.indices, id: \.self) { index in
                VStack {
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 50)
                                .foregroundColor(steps[index].isSelected ? .blue : .white)
                                .overlay(
                                    Circle().stroke(Color.blue, lineWidth: 3)
                                )
                            
                            if steps[index].isSelected {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.gray)
                            } else {
                                Text("\(steps[index].num)")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        VStack(alignment: .leading) {
                            Text(steps[index].titre)
                                .foregroundColor(steps[index].isSelected ? .gray : .black)
                            Text(steps[index].description)
                                .foregroundColor(steps[index].isSelected ? .gray : .black)
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

