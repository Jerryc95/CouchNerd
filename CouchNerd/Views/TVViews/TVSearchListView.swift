//
//  TVSearchListView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/26/22.
//

import SwiftUI

struct TVSearchListView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var tvNetworker: TVNetworker
    
    var body: some View {
        ScrollView {
            if tvNetworker.tvShows.results.count != 0 {
                ForEach(tvNetworker.tvShows.results, id: \.self) { show in
                    HStack {
                        if show.posterPath != nil {
                            NavigationLink(destination: TVDetailView(tvShow: show)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(Color.secondarySystemGroupedBackground)
                                    HStack {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(show.posterPath ?? "")")) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 75, height: 112.5)
                                        } placeholder: {
                                            Color.gray.opacity(0.0)
                                                .frame(width: 75, height: 112.5)
                                        }
                                        Text(show.name)
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
                    .padding(3)
                }
            } else {
                Text("No shows found. Try searching for something else.")
                    .multilineTextAlignment(.center)
                    .font(.callout)
                    .padding()
            }
        }
    }
}

struct TVSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        TVSearchListView()
    }
}
