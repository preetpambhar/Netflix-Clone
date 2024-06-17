//
//  Movie .swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-16.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let orignal_name: String?
    let orignal_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

/*
 adult = 0;
 "backdrop_path" = "/7cqKGQMnNabzOpi7qaIgZvQ7NGV.jpg";
 "first_air_date" = "2019-07-25";
 "genre_ids" =             (
     10765,
     10759
 );
 id = 76479;
 "media_type" = tv;
 name = "The Boys";
 "origin_country" =             (
     US
 );
 "original_language" = en;
 "original_name" = "The Boys";
 overview = "A group of vigilantes known informally as \U201cThe Boys\U201d set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.";
 popularity = "1826.857";
 "poster_path" = "/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg";
 "vote_average" = "8.472";
 "vote_count" = 9534;
 */
