//
//  AstuceView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 29/07/2024.
//
import SwiftUI
import AVKit

struct AstuceView: View {
    let astuce: Astuce
    @State private var showingSteps = false
    @State private var player: AVPlayer?
    @State private var playerItem: AVPlayerItem?

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Video Player
                if let player = player {
                    VideoPlayer(player: player)
                        .onAppear {
                            player.play()
                        }
                        .onDisappear {
                            player.pause()
                        }
                        .aspectRatio(9/16, contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .ignoresSafeArea()
                } else {
                    Text("Loading video...")
                        .onAppear {
                            loadVideo()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: {
                                print("Like button tapped")
                            }) {
                                Image(systemName: "heart")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                            }

                            Button(action: {
                                print("Comment button tapped")
                            }) {
                                Image(systemName: "message")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }

                            Button(action: {
                                print("Favorite button tapped")
                            }) {
                                Image(systemName: "star")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .ignoresSafeArea()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
            .gesture(
                LongPressGesture()
                    .onEnded { _ in
                        showingSteps.toggle()
                    }
            )
            .sheet(isPresented: $showingSteps) {
//                StepsView(steps: astuce.steps)
            }
        }
        .ignoresSafeArea()
    }

    private func loadVideo() {
        let videoName = astuce.video
        if let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
            playerItem = AVPlayerItem(url: videoURL)
            player = AVPlayer(playerItem: playerItem)
            player?.volume = 1.0
        } else {
            print("Failed to find video: \(videoName).mp4")
        }
    }
}
