//
//  AstuceView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 29/07/2024
//  Modified by Aurélien
//

import SwiftUI
import AVKit

/// `AstuceView` représente une vue individuelle pour une astuce et affiche la vidéo associée  à l'aide d'un lecteur vidéo (`AVPlayer`)
struct AstuceView: View {
    var index: Int
    @Binding var players: [Int: AVPlayer]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let player = players[index] {
                    VideoPlayer(player: player)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                } else {
                    Text("Loading video...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .font(.title)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
