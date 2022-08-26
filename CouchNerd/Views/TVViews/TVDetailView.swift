//
//  TVDetailView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/26/22.
//

import SwiftUI

struct TVDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var movieNetworker: MovieNetworker
    
    @State private var showAlert = false
    @State private var isAddingShow = false
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.id)
    ]) var tvShows: FetchedResults<CDTVShow>
    
    var tvShow: TVShow
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(tvShow.backdropPath ?? "")")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                LinearGradient(gradient: Gradient(colors: [.black.opacity(0.0), .black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                            }
                        
                    } placeholder: {
                        Color.black
                    }
                    VStack {
                        HStack(alignment: .top) {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(tvShow.posterPath ?? "")")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 125, height: 187.5)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 10)
                                    )
                                    .offset(y: -35)
                                    
                                
                            } placeholder: {
                                Color.black.opacity(0.0)
                            }
                            VStack {
                                    HStack {
                                        ZStack {
                                            ProgressView(value: tvShow.voteAverage!, total: 10.0)
                                                .progressViewStyle(RatingProgressStyle(rating: tvShow.voteAverage ?? 0))
                                            Text("\(String(format: "%.1f", tvShow.voteAverage!))")
                                            
                                        }
                                        Text("Rating")
                                            .font(.subheadline)
                                    }
                                
                                Text(tvShow.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .offset(y: -10)
                                
                                HStack {
                                    if tvShow.genreIDs != nil {
                                        ForEach(tvShow.genreIDs!, id: \.self) { genre in
                                            Text("\(movieNetworker.movies.convertGenre(ID: genre))")
                                                .foregroundColor(.secondary)
                                                .font(.subheadline)
                                        }
                                    }
                                }
                                .padding(.top, 3)
                                Text("\(formatDate(date: tvShow.firstAirDate!))")
                                    .foregroundColor(.secondary)
                                    .font(.subheadline)
                            }
                            .offset(y: -15)
                            .frame(width: 200)
                            .padding()
                        }
                        
                        Divider()
                        HStack {
                            Text("Synopsis")
                                .padding(.leading)
                                .font(.subheadline)
                            Spacer()
                        }
                        
                        Text(tvShow.overview)
                            .padding()
                        Spacer()
                        Button(action: {
                            if tvShows.contains(where: { $0.id == tvShow.id } ) {
                                showAlert = true
                            } else {
                                isAddingShow = true
                            }
                        }, label: {
                            Text("Add to List")
                        })
                        .buttonStyle(AddButtonStyle(gradient: GradientColors().tvGradient))
                    }
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $isAddingShow, content: {
            AddTVShowView(tvShow: tvShow)
        })
        .alert("Show already added to list", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
    
    
    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd"
        let newDate = dateFormatter.date(from: date)
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d, yyyy")
        return dateFormatter.string(from: newDate!)
    }
}

struct TVDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TVDetailView(tvShow: TVShow.example)
    }
}
