//
//  CDHelpers.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/4/22.
//

import Foundation

extension CDMovie {
    static var example: CDMovie {
        let controller = DataController()
        let viewContext = controller.container.viewContext
        
        let movie = CDMovie(context: viewContext)
        
        
        return movie
    }
    
    var status: String {
        watchStatus ?? ""
    }
    
    var movieReview: String {
        review ?? ""
    }
}

extension CDTVShow {
    static var example: CDTVShow {
        let controller = DataController()
        let viewContext = controller.container.viewContext
        
        let tvShow = CDTVShow(context: viewContext)
        
        return tvShow
    }
    
    var status: String {
        watchStatus ?? ""
    }
    
    var tvShowReview: String {
        review ?? ""
    }
}

extension CDGame {
    static var example: CDGame {
        let controller = DataController()
        let viewContext = controller.container.viewContext
        
        let game = CDGame(context: viewContext)
        
        return game
    }
    
    var status: String {
        playStatus ?? ""
    }
    
    var gameReview: String {
        review ?? ""
    }
    
    var gameScreenshotURLs: [String] {
        screenshotURLs ?? [""]
    }
}
