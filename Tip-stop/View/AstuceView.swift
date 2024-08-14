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
    @Binding var hasSeenOnboarding: Bool
    @Binding var currentIndex: Int
    @Binding var players: [Int: AVPlayer]

    init(astuce: Astuce, currentIndex: Binding<Int>, players: Binding<[Int: AVPlayer]>, hasSeenOnboarding: Binding<Bool>) {
        self.astuce = astuce
        _mutableAstuce = State(initialValue: astuce)
        self._currentIndex = currentIndex
        self._players = players
        self._hasSeenOnboarding = hasSeenOnboarding
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let player = player {
                    VideoPlayer(player: player)
                        .onAppear {
                            if hasSeenOnboarding {
                                player.play()
                            }                        }
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
                                    Text("\(UserDefaults.standard.integer(forKey: "likeCount_\(astuce.video)"))")
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
                            // Ajout bouton showingSteps
                            Button(action: {
                                showingSteps.toggle()
                            }) {
                                Image(systemName: "list.bullet.rectangle")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 40)
                                    .padding(.top, 3)
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
// In conflict with TabView swipe
//            .gesture(
//                LongPressGesture()
//                    .onEnded { _ in
//                        showingSteps.toggle()
//                    }
//            )
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
            players[currentIndex] = player
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
