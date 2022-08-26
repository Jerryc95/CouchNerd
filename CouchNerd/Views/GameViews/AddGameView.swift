//
//  AddGameView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/18/22.
//

import SwiftUI

struct AddGameView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var gameNetworker: GameNetworker
    
    @State private var userRating = 0
    @State private var review = ""
    @State private var playStatus = "Not Played"
    @State private var playStatuses = ["Not Played", "Playing", "Finished"]
    
    var game: Game
    
    var body: some View {
        VStack {
            HStack {
                Text(game.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding()
            
            Form {
                Section {
                    Picker("Play Status", selection: $playStatus) {
                        ForEach(playStatuses, id: \.self) { status in
                            Text(status)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                if playStatus != "Not Played" {
                    Section("Rate and Review") {
                        EditRatingView(rating: $userRating)
                        TextEditor(text: $review)
                            .frame(height: 250)
                    }
                }
            }
            Button(action: {
                let newGame = CDGame(context: moc)
                newGame.id = Int64(game.id)
                newGame.name = game.name
                newGame.platformLogos = game.platformLogos
                newGame.coverURL = game.coverURL
                newGame.firstReleaseDate = game.firstReleaseDate
                newGame.playStatus = playStatus
                newGame.review = review
                newGame.rating = game.rating
                newGame.userRating = Int64(userRating)
                newGame.screenshotURLs = game.screenshotURLs
                newGame.platforms = game.platforms
                newGame.summary = game.summary
                
                try? moc.save()
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Save")
            })
            .buttonStyle(AddButtonStyle(gradient: GradientColors().gameGradient))
        }
        .background(Color.systemGroupedBackground)
    }
}

struct AddGameView_Previews: PreviewProvider {
    static var previews: some View {
        AddGameView(game: Game.example)
    }
}
