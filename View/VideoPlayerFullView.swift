//
//  VideoPlayerFullView.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 28/05/25.
//

import Foundation
import SwiftUI
import AVKit


struct VideoPlayerFullView: View {
    let videoURL: URL
    @State private var player: AVPlayer?

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                player = AVPlayer(url: videoURL)
                player?.play()
            }
            .onDisappear {
                player?.pause()
            }
            .edgesIgnoringSafeArea(.all)
    }
}
