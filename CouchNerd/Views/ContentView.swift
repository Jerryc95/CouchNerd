//
//  ContentView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/23/22.
//

import SwiftUI

struct ContentView: View {
//    @EnvironmentObject var dataController: DataController
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isViewingSettings = false
    
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    HStack {
                        Text("My Lists")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.top)
                    LazyVGrid(columns: [.init(), .init()]) {
                        SavedView(icon: "play.circle.fill", iconColor: GradientColors().movieGradient, title: "Movies", destination: SavedMoviesView())
                        SavedView(icon: "play.rectangle.fill", iconColor: GradientColors().tvGradient, title: "TV & Anime", destination: SavedTVShowView())
                        SavedView(icon: "play.circle.fill", iconColor: GradientColors().gameGradient, title: "Games", destination: SavedGameView())
                        SavedView(icon: "star.fill", iconColor: GradientColors().favoriteGradient, title: "Favorites", destination: FavoritesView())
                    }
                }
                .padding(.horizontal)
                
                Section {
                    HStack {
                        Text("Discover")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding()
                    
                        DiscoverView(icon: "play.circle.fill", iconColor: GradientColors().movieGradient, title: "Movies", destination: MovieSearchView())
                        .frame(height: 50)
                        DiscoverView(icon: "play.rectangle.fill", iconColor: GradientColors().tvGradient, title: "TV & Anime", destination: TVSearchView())
                        .frame(height: 50)
                        DiscoverView(icon: "play.rectangle.fill", iconColor: GradientColors().gameGradient, title: "Games", destination: GameSearchView())
                        .frame(height: 50)
                    
                   Spacer()
                }
            }
            .background(Color.systemGroupedBackground)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .navigationTitle("Couch Nerd")
            .toolbar {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
