//
//  AddTVShowView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/16/22.
//

import SwiftUI

struct AddTVShowView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var tvNetwork: TVNetworker

    @State private var rating = 0
    @State private var review = ""
    @State private var watchStatus = "Unwatched"
    @State private var watchStatuses = ["Unwatched", "Watching", "Waiting", "Finished"]
    
    var tvShow: TVShow
    
    var body: some View {
        VStack {
            HStack {
                Text(tvShow.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding()
            
            Form {
                Section("Watch Status") {
                    Picker("Watch Status", selection: $watchStatus) {
                        ForEach(watchStatuses, id: \.self) { status in
                            Text(status)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
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
                let newTVShow = CDTVShow(context: moc)
                newTVShow.id = Int64(tvShow.id)
                newTVShow.name = tvShow.name
                newTVShow.firstAirDate = tvShow.firstAirDate
                newTVShow.overview = tvShow.overview
                newTVShow.posterPath = tvShow.posterPath
                newTVShow.backdropPath = tvShow.backdropPath
                newTVShow.voteAverage = tvShow.voteAverage ?? 0
                newTVShow.review = review
                newTVShow.rating = Int16(rating)
                newTVShow.watchStatus = watchStatus
                
                try? moc.save()
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Save")
            })
            .buttonStyle(AddButtonStyle(gradient: GradientColors().tvGradient))

        }
        .padding()
        .background(Color.systemGroupedBackground)
    }
}

struct AddTVShowView_Previews: PreviewProvider {
    static var previews: some View {
        AddTVShowView(tvShow: TVShow.example)
    }
}
