//
//  AstuceView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 29/07/2024.
//
import SwiftUI

struct AstuceView: View {
    let astuce: Astuce
    @State private var showingSteps = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .overlay(
                        VStack {
                            Text("Video \(astuce.id.uuidString.prefix(6))")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity),
                        alignment: .center
                    )
                    .onLongPressGesture {
                        showingSteps.toggle()
                    }

                VStack {
                    Spacer()
                    
                    HStack {
                        VStack {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "heart")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom, 20)

                            Button(action: {
                                
                            }) {
                                Image(systemName: "message")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom, 20)

                            Button(action: {
                                
                            }) {
                                Image(systemName: "star")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                    }
                }
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
            .sheet(isPresented: $showingSteps) {
                StepsView(steps: astuce.steps)
            }
        }
        .ignoresSafeArea()
    }
}
