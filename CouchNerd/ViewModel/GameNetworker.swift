//
//  GameNetworker.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/28/22.
//

import Foundation
import IGDB_SWIFT_API

class GameNetworker: ObservableObject {
    @Published var topGames: [Game] = []
    @Published var games: [Game] = []
    
    init() {}
    
    let wrapper = IGDBWrapper(clientID: APIKeys().IGDBClientID, accessToken: APIKeys().IGDBAccessToken)
   
    
    func fetchTopGames() {
        let apicalypse = APICalypse()
                  .fields(fields: "name, id, rating, cover.image_id, screenshots.image_id, first_release_date, platforms.name, platforms.platform_logo.image_id, platforms.platform_family, summary")
                  .limit(value: 10)
                  .sort(field: "release_dates.date", order: .ASCENDING)
                  .where(query: "rating >= 85 & themes != 42 & first_release_date > 1641877200 ")

        wrapper.apiProtoRequest(endpoint: .GAMES, apicalypseQuery: apicalypse.buildQuery(),
            dataResponse: { data in
                guard let gameResults = try? Proto_GameResult(serializedData: data) else { return }
                DispatchQueue.main.async {
                    self.topGames = gameResults.games.map { Game(game: $0) }
                }
            },
            errorResponse: { error in
                print("error: \(error)")
            }
        )
    }
    
    func fetchGames(query: String) {
        let apicalpyse = APICalypse()
            .search(searchQuery: query)
            .limit(value: 50)
            .fields(fields: "name, id, rating, cover.image_id, screenshots.image_id, first_release_date, platforms.name, platforms.platform_logo.image_id, summary, storyline")
            .where(query: "themes != 42")
        
        wrapper.apiProtoRequest(endpoint: .GAMES, apicalypseQuery: apicalpyse.buildQuery(), dataResponse: { data in
            guard let gameResults = try? Proto_GameResult(serializedData: data) else { return }
            DispatchQueue.main.async {
                print(gameResults)
                self.games = gameResults.games.map { Game(game: $0) }
            }
        }, errorResponse: { error in
            print("error:\(error)")
        })
    }
}

private extension Game {
    
    init(game: Proto_Game, coverSize: ImageSize = .COVER_BIG) {
        let coverURL = imageBuilder(imageID: game.cover.imageID, size: coverSize, imageType: .PNG)
      
        
        let screenshotURLs = game.screenshots.map { (scr) -> String in
            let url = imageBuilder(imageID: scr.imageID, size: .SCREENSHOT_BIG, imageType: .JPEG)
            return url
        }
        
        let platforms = game.platforms.map { $0.name }
        
        let platformLogos = game.platforms.map { (logo) -> String in
            let logo = imageBuilder(imageID: logo.platformLogo.imageID, size: .LOGO_MEDIUM, imageType: .PNG)
            return logo
        }
        
        self.init(id: Int(game.id),
                  name: game.name,
                  rating: game.rating,
                  storyline: game.storyline,
                  summary: game.summary,
                  coverURL: coverURL,
                  screenshotURLs: screenshotURLs,
                  firstReleaseDate: game.firstReleaseDate.date,
                  platforms: platforms,
                  platformLogos: platformLogos
                 )
        
    }
    
}
