//
//  AddMovieView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/29/22.
//

import SwiftUI
import CoreData

struct AddMovieView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var movieNetworker: MovieNetworker
    
    @State private var rating = 0
    @State private var review = ""
    @State private var watchStatus = "Unwatched"
    @State private var watchStatuses = ["Unwatched", "Watched"]
    
    var movie: Movie
    
    var body: some View {
        VStack {
            HStack {
                    Text(movie.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                Spacer()

                }
                .padding()
           
            Form {
                Section {
                    Picker("Watch Status", selection: $watchStatus) {
                        ForEach(watchStatuses, id: \.self) { status in
                            Text(status)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                if watchStatus != "Unwatched" {
                    Section("Rate and Review") {
                        EditRatingView(rating: $rating)
                        TextEditor(text: $review)
                            .frame(height: 250)
                    }
                }
               
            }
            
            Button(action: {
                let newMovie = CDMovie(context: moc)
                newMovie.id = Int64(movie.id)
                newMovie.title = movie.title
                newMovie.overview = movie.overview
                newMovie.voteAverage = movie.voteAverage ?? 0
                newMovie.posterPath = movie.posterPath
                newMovie.backdropPath = movie.backdropPath
                newMovie.releaseDate = movie.releaseDate
                newMovie.watchStatus = watchStatus
                newMovie.rating = Int16(rating)
                newMovie.review = review
                
                try? moc.save()
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Save")
            })
            .buttonStyle(AddButtonStyle(gradient: GradientColors().movieGradient))
            
            
            
        }
       
        .padding()
        .background(Color.systemGroupedBackground)
    }
}

struct AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieView(movie: Movie.example)
    }
}
