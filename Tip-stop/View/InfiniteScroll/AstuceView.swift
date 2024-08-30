//
//  AstuceView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 29/07/2024
//  Modified by Aurélien
//

import SwiftUI
import AVKit

/// `AstuceView` représente une vue individuelle pour une astuce
struct AstuceView: View {
    let astuce: Astuce
    @State private var player: AVPlayer?
    // Index courant du TabView pour savoir si la vidéo doit être lue
    @Binding var currentIndex: Int
    // Index de l'astuce dans la liste
    var index: Int
    // Dictionnaire stockant les lecteurs vidéo pour chaque astuce
    @Binding var players: [Int: AVPlayer]

    init(astuce: Astuce, currentIndex: Binding<Int>, index: Int, players: Binding<[Int: AVPlayer]>) {
        self.astuce = astuce
        self._currentIndex = currentIndex
        self.index = index
        self._players = players
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let player = player {
                    VideoPlayer(player: player)
                        .aspectRatio(contentMode: .fill)
                        .onAppear {
                            if currentIndex == index {
                                player.play()
                            }
                            setupLooping()
                        }
                        .onDisappear {
                            player.pause()
                        }
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
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
        }
        .edgesIgnoringSafeArea(.all)
    }

    /// Charge la vidéo associée à l'astuce
    private func loadVideo() {
        let videoName = astuce.video
        if let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
            let playerItem = AVPlayerItem(url: videoURL)
            player = AVPlayer(playerItem: playerItem)
            player?.volume = 1.0
            players[index] = player
            setupLooping()
        } else {
            print("Failed to find video: \(videoName).mp4")
        }
    }

    /// Configure la lecture en boucle de la vidéo
    private func setupLooping() {
        player?.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { [weak player] _ in
            player?.seek(to: .zero)
            player?.play()
        }
    }
}
