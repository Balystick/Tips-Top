//
//  VideoThumbnailView.swift
//  Tip-stop
//
//  Created by Aurélien on 30/08/2024.
//

import SwiftUI
import AVKit

struct VideoThumbnailView: View {
    @Binding var path: NavigationPath
    @Binding var favoriteVideoSelected: String?
    let videoToPlay: String
    @Binding var currentPlayingVideo: String?
    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            if let player = player {
                CustomVideoPlayerView(player: player)
                    .aspectRatio(contentMode: .fill)
                    .onAppear {
                        if currentPlayingVideo == videoToPlay {
                            player.play()
                        } else {
                            player.pause()
                        }
                    }
                    .onChange(of: currentPlayingVideo) {
                        if currentPlayingVideo == videoToPlay {
                            player.play()
                        } else {
                            player.pause()
                        }
                    }
                    .onTapGesture {
                        if currentPlayingVideo == videoToPlay {
                            favoriteVideoSelected = videoToPlay
                            path.removeLast()
                        } else {
                            currentPlayingVideo = videoToPlay
                        }
                    }
                    .onDisappear {
                        stopAndCleanupPlayer()
                    }
            } else {
                Text("Loading...")
                    .onAppear {
                        setupPlayer(with: videoToPlay)
                    }
            }
        }
    }

    private func setupPlayer(with videoURLString: String) {
        if let url = URL(string: videoURLString) {
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            
            // Observer la fin de la lecture, revenir au début de la vidéo et rejouer
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: .main) { _ in
                player?.seek(to: .zero)
                player?.play()
            }
        } else {
            print("Invalid URL string: \(videoURLString)")
        }
    }
    
    private func stopAndCleanupPlayer() {
        player?.pause()
        player?.replaceCurrentItem(with: nil)  // Libére la vidéo actuelle
        player = nil
        currentPlayingVideo = nil
        // retire l'observateur de notification lorsque le player est libéré
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
}
