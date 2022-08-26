//
//  SearchView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/24/22.
//

import SwiftUI

struct MovieSearchView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var movieNetworker: MovieNetworker
    
    @State private var searchQuery = ""
    @State private var isSearching = false
    
    @FocusState private var searchFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Trending Movies")
                        .bold()
                        .font(.title2)
                        .padding(.leading)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(movieNetworker.topMovies.results, id: \.self) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
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
                            Text("Discover Movies")
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
                                    TextField("Search a movie...", text: $searchQuery)
                                        .focused($searchFocused)
                                        .padding()
                                    Spacer()
                                    Button(action: {
                                        movieNetworker.fetchMovies(query: searchQuery.removeSpace(searchQuery))
                                        isSearching = true
                                        searchFocused = false
                                    }, label: {
                                            Image(systemName: "magnifyingglass")
                                    })
                                    .buttonStyle(SearchButtonStyle(gradient: GradientColors().movieGradient))
                                }
                            }
                    }
                    
                    Section {
                        if isSearching  {
                            MovieSearchListView()
                        } else {
                            Text("Search for a movie above to get more info.")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .background(Color.systemGroupedBackground)
        .onAppear {
            movieNetworker.fetchTopMovies()
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
