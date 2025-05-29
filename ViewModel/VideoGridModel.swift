//
//  VideoGridModel.swift
//  TikTokZee
//
//  Created by Sharda Prasad on 28/05/25.
//

import Foundation

class VideoGridModel: ObservableObject {
    @Published var videos: [VideoItem] = []
    @Published var selectedVideoID: String? = nil
    @Published var isLoading:Bool = false
//    init() async {
//
//        await loadVideosFromJSONAsync()
//    }

    public func loadVideosFromJSONAsync() async {
        
        let jsonString = """
        [
            {"vID":"11","vName":"video_1","vURL":"https://videos.pexels.com/video-files/6992415/6992415-hd_1080_1920_25fps.mp4"},
        {"vID":"12","vName":"video_2","vURL":"https://videos.pexels.com/video-files/9149057/9149057-hd_1080_1920_25fps.mp4"},
            {"vID":"13","vName":"video_3","vURL":"https://videos.pexels.com/video-files/6911341/6911341-uhd_1440_2560_24fps.mp4"},
            {"vID":"14","vName":"video_4","vURL":"https://videos.pexels.com/video-files/6911329/6911329-uhd_1440_2560_24fps.mp4"},
            {"vID":"15","vName":"video_5","vURL":"https://videos.pexels.com/video-files/5893632/5893632-uhd_1440_2560_24fps.mp4"},
            {"vID":"16","vName":"video_6","vURL":"https://videos.pexels.com/video-files/5405545/5405545-uhd_1440_2560_25fps.mp4"},
            {"vID":"17","vName":"video_7","vURL":"https://videos.pexels.com/video-files/29298897/12634728_1440_2560_24fps.mp4"},
            {"vID":"18","vName":"video_8","vURL":"https://videos.pexels.com/video-files/31359132/13382072_1440_2560_24fps.mp4"},
            {"vID":"19","vName":"video_9","vURL":"https://videos.pexels.com/video-files/7404964/7404964-uhd_1440_2732_25fps.mp4"},
            {"vID":"20","vName":"video_10","vURL":"https://videos.pexels.com/video-files/5370829/5370829-uhd_1440_2732_30fps.mp4"},
            {"vID":"21","vName":"video_11","vURL":"https://videos.pexels.com/video-files/6853337/6853337-uhd_1440_2732_25fps.mp4"},
            {"vID":"22","vName":"video_12","vURL":"https://videos.pexels.com/video-files/5556802/5556802-hd_1080_1920_30fps.mp4"},
                    {"vID":"23","vName":"video_13","vURL":"https://videos.pexels.com/video-files/3699618/3699618-uhd_1440_2560_30fps.mp4"}
        ]
        """

        guard let data = jsonString.data(using: .utf8) else { return }

        DispatchQueue.global(qos: .background).async {
            do {
                let decoded = try JSONDecoder().decode([VideoItem].self, from: data)
                DispatchQueue.main.async {
                    self.videos = decoded
                }
            } catch {
                print("Decode error: \(error)")
            }
        }
    }
}
