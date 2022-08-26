//
//  TVShow.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/23/22.
//

import Swift
import Foundation

struct TVShows: Codable {
    var results: [TVShow]
    
    static let example = TVShows(results: [TVShow.example])
}

struct TVShow: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let overview: String
    let genreIDs: [Int]?
    let voteAverage: Float?
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String?
    
    static let example = TVShow(
        id: 31910,
        name: "Naruto Shippūden",
        overview: "Naruto Shippuuden is the continuation of the original animated TV series Naruto.The story revolves around an older and slightly more matured Uzumaki Naruto and his quest to save his friend Uchiha Sasuke from the grips of the snake-like Shinobi, Orochimaru. After 2 and a half years Naruto finally returns to his village of Konoha, and sets about putting his ambitions to work, though it will not be easy, as He has amassed a few (more dangerous) enemies, in the likes of the shinobi organization; Akatsuki.",
        genreIDs: [16, 10759, 10765],
        voteAverage: 8.6,
        posterPath: nil,
        backdropPath: "/3XlKckxPEa4lg5w4vHnyE35PUyI.jpg",
        firstAirDate: "2007-02-15")
}
