//
//  VideeoThumbnailView.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 28/05/25.
//

import Foundation
import SwiftUI
import AVKit


struct VideoThumbnailView: View {
    let videoURL: URL
    let videoURLID: Int
    @State private var player: AVPlayer?

    var body: some View {
        GeometryReader { geo in
            Group {
                if let player = player {
                    VideoPlayer(player: player)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                        .onDisappear {
                            player.pause()
                        }
                } else {
                    
                    Color.gray.opacity(0.2)
                }
            }
            .onAppear {
                let newPlayer = AVPlayer(url: videoURL)
                newPlayer.isMuted = true
                newPlayer.play()
                newPlayer.actionAtItemEnd = .none

                NotificationCenter.default.addObserver(
                    forName: .AVPlayerItemDidPlayToEndTime,
                    object: newPlayer.currentItem,
                    queue: .main
                ) { _ in
                    newPlayer.seek(to: .zero)
                    newPlayer.play()
                }

                self.player = newPlayer
            }
        }
    }
}



