//
//  SearchResultModel.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-08-16.
//import Foundation

struct SearchListResponse: Decodable {
    let items: [SearchResult]?
}

struct SearchResult: Decodable {
    let id: VideoID?
    let snippet: Snippet?
}

struct VideoID: Decodable {
    let videoId: String?
}

struct Snippet: Decodable {
    let title: String?
    let thumbnails: Thumbnails?
}

struct Thumbnails: Decodable {
    let high: ThumbnailDetail?
}

struct ThumbnailDetail: Decodable {
    let url: String?
}
