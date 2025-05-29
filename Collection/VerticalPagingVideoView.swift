//
//  VerticalPagingVideoView.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 29/05/25.
//

import Foundation
import SwiftUI
import UIKit

struct VerticalPagingVideoView: UIViewControllerRepresentable {
    let videos: [VideoItem]
    let selectedIndex: Int

    func makeUIViewController(context: Context) -> UICollectionViewController {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size

        let collectionViewController = UICollectionViewController(collectionViewLayout: layout)
        collectionViewController.collectionView.isPagingEnabled = true
        collectionViewController.collectionView.showsVerticalScrollIndicator = false
        collectionViewController.collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        collectionViewController.collectionView.dataSource = context.coordinator

        DispatchQueue.main.async {
               let indexPath = IndexPath(item: selectedIndex, section: 0)
            collectionViewController.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
        }
        
        return collectionViewController
    }

    func updateUIViewController(_ uiViewController: UICollectionViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(videos: videos)
    }

    class Coordinator: NSObject, UICollectionViewDataSource {
        let videos: [VideoItem]

        init(videos: [VideoItem]) {
            self.videos = videos
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            videos.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
            cell.configure(with: videos[indexPath.item])
            return cell
        }
    }
}
