//
//  VideoThumbnailView.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 28/05/25.
//

import Foundation
import SwiftUI
import AVFoundation

struct VideoThumbnailViewImageIMG: View {

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss

    let videoURL: URL
    var sel_Index: Int = 0
    var onCloseHome: (Int) -> Void
    @State var localsel_Index: Int = -1
    @State var selectedURL: URL? = nil

    @StateObject public var viewModel = VideoGridModel()
    let videoURLID: Int
    @State private var isFullScreenPresented = false
    @State private var thumbnailImage: UIImage? = nil

    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(
                destination: FullScreenVideoView(
                    videos: viewModel.videos,
                    selectedIndex: sel_Index,
                    onClose: { idx, selectedURL in
                        isFullScreenPresented = false
                        self.localsel_Index = idx
                        self.selectedURL = selectedURL
                        onCloseHome(idx)
                    }
                )
                .navigationBarBackButtonHidden(true)
            ) {
                
                ZStack(alignment: .topTrailing) {
                    
                    if let image = thumbnailImage {
                        
                        let itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 16, height: 180)

                        Group {
                            if localsel_Index >= 0, let localURL = selectedURL {
                                
                                VideoThumbnailView(videoURL: localURL, videoURLID: localsel_Index)
                            }else {
                                
                                Image(uiImage: image)
                                    .resizable()
                            }
                        }.frame(width: itemSize.width, height: itemSize.height)
                            .scaledToFill()
                            .clipped()
                            .cornerRadius(4)
                    } else {
                        
                        ProgressView()
                            .frame(height: 180)
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.2))
                            .cornerRadius(4)
                    }

                    if localsel_Index >= 0 {
                        Button(action: {
                            localsel_Index = -1 // Hide preview
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.6))
                                .clipShape(Circle())
                                .padding(8)
                        }
                    }
                }
            }
        
        }
        .onAppear {
            generateThumbnail()
        }
    }

    private func generateThumbnail() {
        let asset = AVAsset(url: videoURL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true

        let time = CMTime(seconds: 1, preferredTimescale: 60)
        DispatchQueue.global().async {
            do {
                let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                let uiImage = UIImage(cgImage: cgImage)
                DispatchQueue.main.async {
                    self.thumbnailImage = uiImage
                    self.selectedURL = videoURL
                }
            } catch {
                print("Failed to generate thumbnail: \(error.localizedDescription)")
            }
        }
    }
}
