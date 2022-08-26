//
//  Manga.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/23/22.
//
import Foundation

struct AllManga: Codable {
    let results: [Manga]
    
    enum CodingKeys: String, CodingKey {
        case results = "data"
    }
    
    static let example = AllManga(results: [Manga.example])
}

struct Manga: Codable, Hashable {
    let rank: Int
    let title: String
    let titleEnglish: String?
    let synopsis: String
    let chapters: Int?
    let volumes: Int?
    let score: Double?
    let publishedDate: PublishedDate?
    let images: [String: Images]
    
//    enum CodingKeys: String, CodingKey, Codable {
//        case rank, title, titleEnglish, synopsis, chapters, volumes, score
//        case publisheDate = "published"
//        case images = "image"
//    }
    
    
    static let example = Manga(rank: 1, title: "", titleEnglish: "", synopsis: "", chapters: 1, volumes: 1, score: 1.0, publishedDate: PublishedDate(string: ""), images: ["jpg": Images(imageURL: "", smallImageURL: "", largeImageURL: "")] )
    
}

struct PublishedDate: Codable, Hashable {
    let string: String
}


struct Images: Codable, Hashable {
    let imageURL: String?
    let smallImageURL: String?
    let largeImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}
