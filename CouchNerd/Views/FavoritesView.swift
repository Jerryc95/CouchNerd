//
//  FavoritesView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/22/22.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var category = "Games"
    @State private var categories = ["Games", "TV & Anime", "Movies"]
    
    var body: some View {
        VStack {
            Picker("Category", selection: $category) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            if category == "Games" {
                FavoriteGamesView()
            } else if category == "TV & Anime" {
                FavoriteTVShowsView()
            } else {
                FavoriteMoviesView()
            }
            Spacer()
        }
        .background(Color.systemGroupedBackground)
        .navigationTitle("Favorites")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
