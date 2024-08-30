//
//  CustomVideoPlayerView.swift
//  Tip-stop
//
//  Created by Aurélien on 30/08/2024.
//

import SwiftUI
import AVKit

struct CustomVideoPlayerView: UIViewRepresentable {
    let player: AVPlayer

    func makeUIView(context: Context) -> UIView {
        let view = UIView()

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill

        view.layer.addSublayer(playerLayer)

        DispatchQueue.main.async {
            playerLayer.frame = view.bounds
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let playerLayer = uiView.layer.sublayers?.first as? AVPlayerLayer {
            playerLayer.frame = uiView.bounds
        }
    }
}

