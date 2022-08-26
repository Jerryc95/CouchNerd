//
//  TVSearchView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/26/22.
//

import SwiftUI
import Combine

struct TVSearchView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var tvNetworker: TVNetworker

    @State private var searchQuery = ""
    @State private var isSearching = false

    @FocusState private var searchFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Trending Shows")
                        .bold()
                        .font(.title2)
                        .padding(.leading)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(tvNetworker.topTVShows.results, id: \.self) { tvShow in
                            NavigationLink(destination: TVDetailView(tvShow: tvShow)) {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(tvShow.posterPath ?? "")")) { image in
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
                            Text("Discover Shows")
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
                                    TextField("Search a tv show or anime...", text: $searchQuery)
                                        .focused($searchFocused)
                                        .padding()
                                    
                                    Spacer()
                                    Button(action: {
                                        tvNetworker.fetchTVShows(query: searchQuery.removeSpace(searchQuery))
                                        isSearching = true
                                        searchFocused = false
                                    }, label: {
                                        Image(systemName: "magnifyingglass")
                                    })
                                    .buttonStyle(SearchButtonStyle(gradient: GradientColors().tvGradient))
                                }
                            }
                    }
                    Section {
                        if isSearching  {
                            TVSearchListView()
                        } else {
                            Text("Search for a tv show or anime above to get more info.")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .background(Color.systemGroupedBackground)
        .onAppear {
            tvNetworker.fetchTopTVShows()
        }
    }
}

struct TVSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TVSearchView()
    }
}
