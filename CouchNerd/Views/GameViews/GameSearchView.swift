//
//  GameSearchView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/29/22.
//

import SwiftUI

struct GameSearchView: View {
    @EnvironmentObject var gameNetworker: GameNetworker
    
    @State private var searchQuery = ""
    @State private var isSearching = false
    
    @FocusState private var searchFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Trending Games")
                        .bold()
                        .font(.title2)
                        .padding(.leading)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(gameNetworker.topGames, id: \.self) { game in
                            NavigationLink(destination: GameDetailView(game: game)) {
                                AsyncImage(url: URL(string: game.coverURL)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 175, height: 262.5)
                                } placeholder: {
                                    Color.gray.opacity(0.0)
                                        .frame(width: 175, height: 262.5)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
                
                Section {
                    VStack {
                        HStack {
                            Text("Discover Games")
                                .bold()
                                .font(.title2)
                                .padding(.leading)
                            Spacer()
                        }
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.secondarySystemGroupedBackground)
                            .frame(width: 350, height: 50)
                            .overlay {
                                HStack {
                                    TextField("Search a game...", text: $searchQuery)
                                        .focused($searchFocused)
                                        .padding()
                                    
                                    Spacer()
                                    Button(action: {
                                        gameNetworker.fetchGames(query: searchQuery)
                                        searchFocused = false
                                        isSearching = true
                                    }, label: {
                                        Image(systemName: "magnifyingglass")
                                    })
                                    .buttonStyle(SearchButtonStyle(gradient: GradientColors().gameGradient))
                                }
                            }
                    }
                    
                    Section {
                        if isSearching {
                            GameSearchListView()
                        } else {
                            Text("Search for a game above to get more info.")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .background(Color.systemGroupedBackground)
        .onAppear {
            gameNetworker.fetchTopGames()
        }
    }
}

struct GameSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GameSearchView()
    }
}
