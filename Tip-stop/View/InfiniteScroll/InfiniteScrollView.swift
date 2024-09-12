//
//  InfiniteScrollView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024
//  Modified by Aurélien
//

import SwiftUI
import AVKit

struct InfiniteScrollView: View {
    @Binding var path: NavigationPath
    @ObservedObject var globalDataModel: GlobalDataModel
    @StateObject private var viewModel = InfiniteScrollViewModel()
    @State var categoryTitre: String
    @State private var currentIndex: Int = 0
    @State private var lastPlayedIndex: Int?
    @Binding var favoriteVideoSelected: String?
    @State private var players: [Int: AVPlayer] = [:]
    @State private var isLiked: [Int: Bool] = [:]
    @State private var isFavorited: [Int: Bool] = [:]
    @State private var showingComments = false
    @State private var showingSteps = false
    @State private var currentSteps: [Step] = []

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            TabView(selection: $currentIndex) {
                ForEach(Array(viewModel.astuces.enumerated()), id: \.element.id) { index, astuce in
                    AstuceView(
                        index: index,
                        players: $players
                    )
                    .tag(index)
                    .onAppear {
                        playCurrentVideo(at: index)
                        isLiked[index] = viewModel.getStoredLikeStatus(for: astuce.video)
                        isFavorited[index] = viewModel.getStoredFavorite(for: astuce.video)
                    }
                    .onDisappear {
                        if let player = players[index] {
                            player.pause()
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
            .onChange(of: currentIndex) { oldIndex, newIndex in
                playCurrentVideo(at: newIndex)
            }
            
            VStack {
                Spacer().frame(height: 40)
                
                HStack {
                    Button(action: {
                        path.append("DecouverteView")
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.001))
                                .frame(width: 75, height: 75)
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.leading, 15)
                    
                    Spacer()
                    
                    Button(action: {
                        lastPlayedIndex = currentIndex
                        path.append("ProfileView")
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.001))
                                .frame(width: 75, height: 75)
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            toggleLike(at: currentIndex)
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.black.opacity(0.001))
                                    .frame(width: 75, height: 75)
                                VStack {
                                    Image(systemName: isLiked[currentIndex] == true ? "heart.fill" : "heart")
                                        .font(.title)
                                        .foregroundColor(.white)
                                    Text(getLikesCount())
                                        .foregroundColor(.white)
                                        .font(.caption)
                                }
                                .padding()
                            }
                        }
                        
                        Button(action: {
                            showingComments = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.black.opacity(0.001))
                                    .frame(width: 75, height: 75)
                                Image(systemName: "message")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Button(action: {
                            toggleFavorite(at: currentIndex)
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.black.opacity(0.001))
                                    .frame(width: 75, height: 75)
                                Image(systemName: isFavorited[currentIndex] == true ? "star.fill" : "star")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        
                        Button(action: {
                            currentSteps = viewModel.astuces[currentIndex].steps  // Set the steps for the current Astuce
                            showingSteps.toggle()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.black.opacity(0.001))
                                    .frame(width: 75, height: 75)
                                Image(systemName: "list.bullet.rectangle")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 40)
                                    .padding(.top, 3)
                            }
                        }
                    }
                }
            }
            .padding(.trailing, 15)
        }
        .onAppear {
            if favoriteVideoSelected != nil {
                insertAndPlayFavoriteVideo()
            } else if let index = lastPlayedIndex {
                currentIndex = index
                DispatchQueue.main.async {
                    playCurrentVideo(at: index)
                }
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .sheet(isPresented: $showingComments) {
            CommentaireView(commentaires: viewModel.astuces[currentIndex].commentaires)
        }
        .sheet(isPresented: $showingSteps) {
            StepsView(steps: $currentSteps)  // Pass the current steps to the StepsView
        }
    }
    
    private func insertAndPlayFavoriteVideo() {
        guard let favoriteVideoString = favoriteVideoSelected else {
            print("No favorite video selected")
            return
        }
        
        let favoriteVideoFileName = URL(string: favoriteVideoString)?.lastPathComponent.replacingOccurrences(of: ".mp4", with: "")
        
        if let favoriteAstuce = viewModel.astuces.first(where: { $0.video == favoriteVideoFileName }) {
            if let existingIndex = viewModel.astuces.firstIndex(where: { $0.video == favoriteAstuce.video }) {
                viewModel.astuces.remove(at: existingIndex)
                if existingIndex <= currentIndex {
                    currentIndex = max(currentIndex - 1, 0)
                }
            }
            
            let insertIndex: Int
            if currentIndex == 0 {
                insertIndex = 0
            } else {
                insertIndex = min(currentIndex + 1, viewModel.astuces.count)
            }
            
            viewModel.astuces.insert(favoriteAstuce, at: insertIndex)
            
            currentIndex = insertIndex
            
            resetPlayers()
            
            DispatchQueue.main.async {
                playCurrentVideo(at: currentIndex)
            }
            
            favoriteVideoSelected = nil
        }
    }
    
    private func resetPlayers() {
        players.removeAll()
        for (index, astuce) in viewModel.astuces.enumerated() {
            loadVideo(for: index)
        }
    }
    
    private func loadVideo(for index: Int) {
        let astuce = viewModel.astuces[index]
        let videoURLString = "https://www.balystick.fr/tipstop/\(astuce.video).mp4"
        
        if let videoURL = URL(string: videoURLString) {
            let playerItem = AVPlayerItem(url: videoURL)
            let player = AVPlayer(playerItem: playerItem)
            player.volume = 1.0
            players[index] = player
            setupLooping(for: player)
        } else {
            // Gestion de l'erreur : l'URL de la vidéo est invalide
            print("Error: Invalid video URL \(videoURLString).")
        }
    }
    
    private func playCurrentVideo(at index: Int) {
        guard index >= 0 && index < viewModel.astuces.count else { return }
        
        stopAllVideos()
        if let player = players[index] {
            player.play()
        } else {
            loadVideo(for: index)
            players[index]?.play()
        }
    }
    
    private func stopAllVideos() {
        for player in players.values {
            player.pause()
            player.seek(to: .zero)
        }
    }
    
    private func setupLooping(for player: AVPlayer) {
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }
    }
    
    private func toggleLike(at index: Int) {
        guard index >= 0 && index < viewModel.astuces.count else { return }
        
        let astuce = viewModel.astuces[index]
        viewModel.toggleLike(for: astuce)
        
        isLiked[index] = viewModel.getStoredLikeStatus(for: astuce.video)
    }
    
    private func getLikesCount() -> String {
        guard currentIndex >= 0 && currentIndex < viewModel.astuces.count else {
            return "0"
        }
        return "\(viewModel.astuces[currentIndex].nombreDeLikes)"
    }
    
    private func toggleFavorite(at index: Int) {
        guard index >= 0 && index < viewModel.astuces.count else { return }
        
        let astuce = viewModel.astuces[index]
        viewModel.toggleFavorite(for: astuce)
        
        isFavorited[index] = viewModel.getStoredFavorite(for: astuce.video)
    }
}
