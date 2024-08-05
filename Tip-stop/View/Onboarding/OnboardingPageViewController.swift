//
//  OnboardingPageViewController.swift
//  Tip-stop
//
//  Created par Aurélien le 29/07/2024.
//

import UIKit
import AVKit
import AVFoundation

/// Extension de UIView pour la lecture en boucle des vidéos
extension UIView {
    func playVideoInLoop(fileName: String, fileType: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: fileType) else {
            debugPrint("\(fileName).\(fileType) not found")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.layer.addSublayer(playerLayer)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak player] _ in
            player?.seek(to: .zero)
            player?.play()
        }
        
        player.play()
    }
}

/// Un view controller pour une page de l'onboarding
class OnboardingPageViewController: UIViewController {
    
    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    var videoName: String?
    var titleText: String?
    var descriptionText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let videoName = videoName {
            videoContainerView.playVideoInLoop(fileName: videoName, fileType: "mp4")
        }
        titleLabel.text = titleText
        label.text = descriptionText
    }
}
