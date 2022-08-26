//
//  CouchNerdApp.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/23/22.
//

import SwiftUI

@main
struct CouchNerdApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var dataController: DataController
    @StateObject var movieNetworker: MovieNetworker
    @StateObject var tvNetworker: TVNetworker
    @StateObject var gameNetworker: GameNetworker
    
    init() {
        let dataController = DataController()
        let movieNetworker = MovieNetworker(movies: Movies.example,topMovies: Movies.example)
        let tvNetwork = TVNetworker(tvShows: TVShows.example, topTVShows: TVShows.example)
        let gameNetworker = GameNetworker()
        
        _dataController = StateObject(wrappedValue: dataController)
        _movieNetworker = StateObject(wrappedValue: movieNetworker)
        _tvNetworker = StateObject(wrappedValue: tvNetwork)
        _gameNetworker = StateObject(wrappedValue: gameNetworker)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(movieNetworker)
                .environmentObject(tvNetworker)
                .environmentObject(gameNetworker)
                .environmentObject(dataController)
        }
        .onChange(of: scenePhase) { _ in
            dataController.save()
        }
    }
}
