//
//  SavedTVShowDetailView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/16/22.
//

import SwiftUI

struct SavedTVShowDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    @EnvironmentObject var dataController: DataController
    
    @State private var rating: Int
    @State private var review: String
    @State private var watchStatus: String
    @State private var watchStatuses = ["Unwatched", "Watching", "Waiting", "Finished"]
    
    var tvShow: CDTVShow
    
    init(tvShow: CDTVShow) {
        self.tvShow = tvShow
        
        _rating = State(wrappedValue: Int(tvShow.rating))
        _review = State(wrappedValue: tvShow.tvShowReview)
        _watchStatus = State(wrappedValue: tvShow.status)
    }
    
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
                                        ProgressView(value: tvShow.voteAverage, total: 10.0)
                                            .progressViewStyle(RatingProgressStyle(rating: tvShow.voteAverage))
                                        Text("\(String(format: "%.1f", tvShow.voteAverage))")
                                        
                                    }
                                    Text("Rating")
                                        .font(.subheadline)
                                }
                                
                                Text(tvShow.name!)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .offset(y: -10)
                                
                                
                                Text("\(formatDate(date: tvShow.firstAirDate!))")
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
                        
                        Text(tvShow.overview ?? "No Synopsis Available")
                            .padding()
                        
                        Picker("Select Status", selection: $watchStatus.onChange(update)) {
                            ForEach(watchStatuses, id: \.self) { status in
                                Text(status)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        
                        if tvShow.watchStatus != "Unwatched" {
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
                                            .submitLabel(.done)
                                        
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
        tvShow.objectWillChange.send()
        
        tvShow.rating = Int16(rating)
        tvShow.watchStatus = watchStatus
        tvShow.review = review
        
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

struct SavedTVShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SavedTVShowDetailView(tvShow: CDTVShow.example)
    }
}
