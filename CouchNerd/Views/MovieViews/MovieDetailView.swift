//
//  MovieDetailView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/25/22.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var networker: MovieNetworker
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.id)
    ]) var movies: FetchedResults<CDMovie>
    
    @State private var isAddingMovie = false
    @State private var showAlert = false
  
    var movie: Movie
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath ?? "")")) { image in
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
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
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
                                            ProgressView(value: movie.voteAverage!, total: 10.0)
                                                .progressViewStyle(RatingProgressStyle(rating: movie.voteAverage ?? 0))
                                            Text("\(String(format: "%.1f", movie.voteAverage!))")
                                            
                                        }
                                        Text("Rating")
                                            .font(.subheadline)
                                    }
                                
                                Text(movie.title)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .offset(y: -10)
                                
                                HStack {
                                    if movie.genreIDs != nil {
                                        ForEach(movie.genreIDs!, id: \.self) { genre in
                                            Text("\(networker.movies.convertGenre(ID: genre))")
                                                .foregroundColor(.secondary)
                                                .font(.subheadline)
                                        }
                                    }
                                }
                                .padding(.top, 3)
                                Text("\(formatDate(date: movie.releaseDate))")
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
                        
                        Text(movie.overview)
                            .padding()
                        Spacer()
                        Button(action: {
                            if movies.contains(where: {$0.id == Int64(movie.id) }) {
                                showAlert = true
                            } else {
                                isAddingMovie = true
                            }
                        }, label: {
                            Text("Add to List")
                        })
                        .buttonStyle(AddButtonStyle(gradient: GradientColors().movieGradient))
                    }
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $isAddingMovie, content: {
            AddMovieView(movie: movie)
        })
        .alert("Movie already added to list", isPresented: $showAlert) {
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

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.example)
    }
}
