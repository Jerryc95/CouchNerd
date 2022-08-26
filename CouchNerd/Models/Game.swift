//
//  Game.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/23/22.
//

import Foundation

struct Game: Codable, Hashable {
    let id: Int
    let name: String
    let rating: Double
    let storyline: String
    let summary: String
    let coverURL: String
    let screenshotURLs: [String]
    let firstReleaseDate: Date
    let platforms: [String]
    let platformLogos: [String]
    
    static let example = Game(id: 1, name: "", rating: 0.0, storyline: "", summary: "", coverURL: "", screenshotURLs: [""], firstReleaseDate: Date(), platforms: [], platformLogos: [])
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        formatter.setLocalizedDateFormatFromTemplate("MMMM d, yyyy")
        return formatter
    }()
}

