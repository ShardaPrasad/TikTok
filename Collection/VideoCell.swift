//
//  VideoCell.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 29/05/25.
//

import Foundation
import UIKit
import AVKit

class VideoCell: UICollectionViewCell {
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?

    override func prepareForReuse() {
        super.prepareForReuse()
        stopPlayback()
    }

    func configure(with video: VideoItem) {
        stopPlayback() // Clean any old playback

        // Create and start AVPlayer
        let player = AVPlayer(url: video.videoURL!)
        player.isMuted = false
        player.play()

        // Configure AVPlayerLayer
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = contentView.bounds
        playerLayer.videoGravity = .resizeAspectFill

        //::-- Add Layer
        contentView.layer.addSublayer(playerLayer)
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak player] _ in
            player?.seek(to: .zero)
            player?.play()
        }
        // Save references
        self.player = player
        self.playerLayer = playerLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = contentView.bounds // Ensure correct sizing
    }

    private func stopPlayback() {
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
    
    @objc private func playerDidReachEnd(_ notification: Notification) {
        if let player = player {
            player.seek(to: .zero)
            player.play()
        }
    }
}

