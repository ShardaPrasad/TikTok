//
//  VideeoItem.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 28/05/25.
//

import Foundation

struct VideoItem: Identifiable, Codable {
    var id: String { vID }
    let vID: String
    let vName: String
    let vURL: String

    var videoURL: URL? {
        URL(string: vURL)
    }
}
