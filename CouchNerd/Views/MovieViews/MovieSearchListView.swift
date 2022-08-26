//
//  MovieSearchListView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/26/22.
//

import SwiftUI

struct MovieSearchListView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var networker: MovieNetworker
    
    var body: some View {
        ScrollView {
            if networker.movies.results.count != 0 {
                ForEach(networker.movies.results, id: \.self) { movie in
                    HStack {
                        if movie.posterPath != nil {
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(Color.secondarySystemGroupedBackground)
                                    HStack {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 75, height: 112.5)
                                        } placeholder: {
                                            Color.gray.opacity(0.0)
                                                .frame(width: 75, height: 112.5)
                                        }
                                        Text(movie.title)
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
                .padding(3)
            } else {
                Text("No Movies found. Try searching for something else.")
                    .multilineTextAlignment(.center)
                    .font(.callout)
                    .padding()
            }
        }
    }
}

struct MovieSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchListView()
    }
}
