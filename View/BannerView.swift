//
//  BannerView.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 28/05/25.
//

import Foundation
import SwiftUI


struct BannerView: View {
    let images = [
        "https://cdn.mos.cms.futurecdn.net/suKJs5vckaK869zr6wG8eM.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdYHRnPZ8-f4fC6ChznqEBc30u6Ekx4zyDaA&s"
    ]

    var body: some View {
        TabView {
            ForEach(images, id: \.self) { url in
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(height: 150)
                .clipped()
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
        .frame(height: 160)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}
