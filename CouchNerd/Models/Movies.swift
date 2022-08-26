//
//  Movie.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/23/22.
//

import Swift

struct Movies: Codable {
    let results: [Movie]

    func convertGenre(ID: Int) -> String {
        switch ID {
        case 28:
            return "Action"
        case 12:
            return "Adventure"
        case 16:
            return "Animation"
        case 35:
            return "Comedy"
        case 80:
            return "Crime"
        case 99:
            return "Documentary"
        case 18:
            return "Drama"
        case 10751:
            return "Family"
        case 14:
            return "Fantasy"
        case 36:
            return "History"
        case 27:
            return "Horror"
        case 10402:
            return "Music"
        case 9648:
            return "Mystery"
        case 10749:
            return "Romance"
        case 878:
            return "Sci-Fi"
        case 10770:
            return "TV Movie"
        case 53:
            return "Thriller"
        case 10742:
            return "War"
        case 37:
            return "Western"
        default:
            return "No Known Genre"
        }
    }


    static let example = Movies(results: [Movie.example])

}

struct Movie: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let genreIDs: [Int]?
    let genres: [Genre]?
    let voteAverage: Float?
    let posterPath: String?
    let backdropPath: String?


    static let example = Movie(
        id: 120,
        title: "The Lord of the Rings: The Fellowship of the Ring",
        overview: "Young hobbit Frodo Baggins, after inheriting a mysterious ring from his uncle Bilbo, must leave his home in order to keep it from falling into the hands of its evil creator. Along the way, a fellowship is formed to protect the ringbearer and make sure that the ring arrives at its final destination: Mt. Doom, the only place where it can be destroyed.",
        releaseDate: "2001-12-18",
        genreIDs: [12,14,28],
        genres: [Genre(id: 12, name: "Fantasy")],
        voteAverage: 8.4,
        posterPath: nil,
        backdropPath: "/tdmlSbLl84hfHx635AqHLB8Qh8M.jpg"
    )
}

struct Genre: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
