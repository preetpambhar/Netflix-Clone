//
//  YoutubeChannel.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-07-04.
//
import Foundation

struct VideoResponse: Decodable {
    let items: [Video]
}

struct Video: Decodable {
    let id: VideoID
    let snippet: Snippet
    
    struct VideoID: Decodable {
        let videoId: String
    }
    
    struct Snippet: Decodable {
        let title: String
        let description: String?
        let publishedAt: String?
        let thumbnails: Thumbnail
    }
    
    struct Thumbnail: Decodable {
        let high: ThumbnailDetail
    }
    
    struct ThumbnailDetail: Decodable {
        let url: String
    }
}

