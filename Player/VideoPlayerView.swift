//
//  VideoPlayerView.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 29/05/25.
//

import Foundation
import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoURL: URL
    @State private var player: AVPlayer?

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                if player == nil {
                    let avPlayer = AVPlayer(url: videoURL)
                    avPlayer.play()
                    player = avPlayer
                } else {
                    player?.play()
                }
            }
            .onDisappear {
                player?.pause()
            }
    }
}
