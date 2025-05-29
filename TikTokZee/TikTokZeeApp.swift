//
//  TikTokZeeApp.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 28/05/25.
//

import SwiftUI

@main
struct TikTokZeeApp: App {
    var body: some Scene {
            WindowGroup {
                AppMainView()
            }
        }
}


struct AppMainView: View {
    var body: some View {
        NavigationStack {
            VideoGridView()
        }
    }
}
