//
//  FullScreenVideoView.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 29/05/25.
//

import SwiftUI
import AVKit


struct FullScreenVideoView: View {
    var videos: [VideoItem]
    var selectedIndex: Int
    var onClose: (Int,URL?) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            VerticalPagingVideoView(videos: videos, selectedIndex: selectedIndex)
                .ignoresSafeArea()

            Button(action: {
                onClose(selectedIndex,videos[selectedIndex].videoURL)
                dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.top, 60)
                    .padding(.trailing, 20)
                    .foregroundColor(.white)
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
}


