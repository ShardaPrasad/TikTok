//
//  VideoGridView.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 28/05/25.
//

import Foundation
import SwiftUI

struct VideoGridView: View {
    @StateObject private var viewModel = VideoGridModel()
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)

    var body: some View {
        VStack(spacing: 0) {
            BannerView()

            ScrollView {
                
                LazyVGrid(columns: columns, spacing: 8) {
                    
                    ForEach(viewModel.videos.indices, id: \.self) { index in
                        
                        let video = viewModel.videos[index]
                        
                        if let url = video.videoURL {
                            VideoThumbnailViewImageIMG(videoURL: url, sel_Index:index,onCloseHome: { selected in
                                
                                
                                
                            } ,viewModel: viewModel, videoURLID: 0)
                        } else {
                            Color.gray.frame(height: 180).cornerRadius(1)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            // ✅ Launch async task correctly
            Task {
                await viewModel.loadVideosFromJSONAsync()
            }
        }
    }
}



