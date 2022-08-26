//
//  GameSearchListView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/15/22.
//

import SwiftUI

struct GameSearchListView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var gameNetworker: GameNetworker

    var body: some View {
        ScrollView {
            if gameNetworker.games.count != 0 {
                ForEach(gameNetworker.games, id: \.self) { game in
                    HStack {
                        if game.coverURL != "" {
                            NavigationLink(destination: GameDetailView(game: game)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(Color.secondarySystemGroupedBackground)
                                    HStack {
                                        AsyncImage(url: URL(string: game.coverURL)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 75, height: 112.5)
                                        } placeholder: {
                                            Color.gray.opacity(0.0)
                                                .frame(width: 75, height: 112.5)
                                        }
                                        Text(game.name)
                                            .bold()
                                            .font(.title3)
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()

                                }
                            }
                        }
                    }
                }
            } else {
                Text("No games found. Try searching for something else.")
                    .multilineTextAlignment(.center)
                    .font(.callout)
                    .padding()
            }
        }
    }
}

struct GameSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        GameSearchListView()
    }
}
