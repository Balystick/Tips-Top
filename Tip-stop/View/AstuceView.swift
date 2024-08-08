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
    @State private var showingComments = false
    @State private var player: AVPlayer?
    @State private var playerItem: AVPlayerItem?
    @EnvironmentObject var viewModel: InfiniteScrollViewModel
    @State private var isLiked: Bool = false
    @State private var isFavorited: Bool = false
    @State private var mutableAstuce: Astuce
    
    init(astuce: Astuce) {
        self.astuce = astuce
        _mutableAstuce = State(initialValue: astuce)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
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
                                toggleLike()
                            }) {
                                VStack {
                                    Image(systemName: isLiked ? "heart.fill" : "heart")
                                        .font(.title)
                                        .foregroundColor(.white)
                                    Text("\(mutableAstuce.nombreDeLikes)")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                }
                                .padding()
                            }

                            Button(action: {
                                showingComments = true
                            }) {
                                Image(systemName: "message")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }

                            Button(action: {
                                isFavorited.toggle()
                                viewModel.toggleFavorite(for: mutableAstuce)
                            }) {
                                Image(systemName: isFavorited ? "star.fill" : "star")
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
            .sheet(isPresented: $showingComments) {
                            CommentaireView(commentaires: astuce.commentaires)
                        }
            .sheet(isPresented: $showingSteps) {
                StepsView()
            }
            .onAppear {
                isLiked = viewModel.getStoredLikeStatus(for: mutableAstuce.video)
                isFavorited = viewModel.getStoredFavorite(for: mutableAstuce.video)
            }
        }
        .ignoresSafeArea()
    }

    private func loadVideo() {
        let videoName = mutableAstuce.video
        if let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
            playerItem = AVPlayerItem(url: videoURL)
            player = AVPlayer(playerItem: playerItem)
            player?.volume = 1.0
        } else {
            print("Failed to find video: \(videoName).mp4")
        }
    }

    private func toggleLike() {
        isLiked.toggle()
        viewModel.toggleLike(for: mutableAstuce)
        
        if isLiked {
            mutableAstuce.nombreDeLikes += 1
        } else {
            mutableAstuce.nombreDeLikes -= 1
        }
    }
}
