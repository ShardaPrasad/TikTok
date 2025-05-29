//
//  VideoGridViewFull.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 28/05/25.
//

import Foundation
import SwiftUI


//
//  VideoGridViewFull.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 28/05/25.
//

import Foundation
import SwiftUI
import AVKit

struct VideoGridViewFull: View {

    @StateObject public var viewModel = VideoGridModel()
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    

    @State private var selectedVideoIndex: Int? = nil
    @State private var isFullScreenPresented = false

    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                VStack(spacing: 0) {
                    BannerView()

                    if viewModel.isLoading {
                        Spacer()
                        ProgressView("Loading Videos...")
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 8) {
                                ForEach(Array(viewModel.videos.enumerated()), id: \.element.id) { index, video in
                                    NavigationLink {
                                        FullScreenVideoView(videos: viewModel.videos, selectedIndex: index, onClose: {_,_  in 
                                            isFullScreenPresented = false
                                        })
                                    } label: {
                                        VideoThumbnailView(videoURL: video.videoURL!, videoURLID: index)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.loadVideosFromJSONAsync()
                    }
                }
            }
        } else {
            // Fallback on earlier versions
            Text("iOS 16 or later is required.")
        }
    }
}
