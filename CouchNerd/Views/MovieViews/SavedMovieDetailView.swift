//
//  SavedMovieDetailView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/2/22.
//

import SwiftUI

struct SavedMovieDetailView: View {
//    @EnvironmentObject var dataController: DataController
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    @State private var rating: Int
    @State private var review: String
    @State private var watchStatus: String
    @State private var watchStatuses = ["Unwatched", "Watched"]
    
    var movie: CDMovie

    init(movie: CDMovie) {
        self.movie = movie
        
        _rating = State(wrappedValue: Int(movie.rating))
        _review = State(wrappedValue: movie.movieReview)
        _watchStatus = State(wrappedValue: movie.status)
    }
    
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
                                        ProgressView(value: movie.voteAverage, total: 10.0)
                                            .progressViewStyle(RatingProgressStyle(rating: movie.voteAverage))
                                        Text("\(String(format: "%.1f", movie.voteAverage))")
                                        
                                    }
                                    Text("Rating")
                                        .font(.subheadline)
                                }
                                
                                Text(movie.title!)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .offset(y: -10)
                                
                                
                                Text("\(formatDate(date: movie.releaseDate!))")
                                    .foregroundColor(.secondary)
                                    .font(.subheadline)
                            }
                            .padding()
                        }
                        
                        Divider()
                        HStack {
                            Text("Synopsis")
                                .padding(.leading)
                                .font(.subheadline)
                            Spacer()
                        }
                        
                        Text(movie.overview ?? "No Synopsis Available")
                            .padding()
                        
                        Picker("Update status", selection: $watchStatus.onChange(update)) {
                            ForEach(watchStatuses, id: \.self) { status in
                                Text(status)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        
                        if movie.watchStatus != "Unwatched" {
                            Divider()
                                HStack {
                                    Text("Review")
                                        .padding(.leading)
                                        .font(.subheadline)
                                    Spacer()
                                }
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(colorScheme == .dark ? Color.secondarySystemGroupedBackground : Color.systemGroupedBackground)
                                .frame(height: 400)
                                .overlay(
                                    VStack {
                                        EditRatingView(rating: $rating.onChange(update))
                                            .padding(.top)
                                        
                                        TextEditor(text: $review.onChange(update))
                                            .frame(width: 350)
                                            .padding()
                                        
                                    }
                                    
                                )
                        }
                        Spacer()
                    }
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
    func update() {
        movie.objectWillChange.send()
        
        movie.watchStatus = watchStatus
        movie.rating = Int16(rating)
        movie.review = review
        
        try? moc.save()
    }
    
    func formatDate(date: String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat =  "yyyy-MM-dd"
        let newDate = dateFormater.date(from: date)
        dateFormater.setLocalizedDateFormatFromTemplate("MMMM d, yyyy")
        return dateFormater.string(from: newDate!)
    }
}

struct SavedMovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SavedMovieDetailView(movie: CDMovie.example)
    }
}
