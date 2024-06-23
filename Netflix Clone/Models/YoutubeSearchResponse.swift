//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-22.
//

import Foundation

/*
 etag = "RzkizSy-KBB87awCSG5g8AE5zgg";
 items =     (
             {
         etag = mp2IWRBy0la1iKB3A1uQ0HK09yQ;
         id =             {
             kind = "youtube#video";
             videoId = "ULEQb_l-N08";
         };
         kind = "youtube#searchResult";
     },
 */

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement : Codable {
    let id: IdVideoElement
}


struct IdVideoElement : Codable{
    let kind: String
    let videoId: String
}
