//
//  SavedGameDetailView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/22/22.
//

import SwiftUI

struct SavedGameDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    @EnvironmentObject var dataController: DataController
    
    @State private var userRating = 0
    @State private var review = ""
    @State private var playStatus = "Not Played"
    @State private var playStatuses = ["Not Played", "Playing", "Finished"]
    
    var game: CDGame
    
    init(game: CDGame) {
        self.game = game
        
        _userRating = State(wrappedValue: Int(game.userRating))
        _review = State(wrappedValue: game.gameReview)
        _playStatus = State(wrappedValue: game.status)
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ZStack {
                    VStack {
                        TabView {
                            ForEach(game.gameScreenshotURLs, id: \.self) { url in
                                AsyncImage(url: URL(string: url)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .overlay {
                                            LinearGradient(gradient: Gradient(colors: [.black.opacity(0.0), .black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                                        }
                                    
                                } placeholder: {
                                    Color.black
                                }
                            }
                        }
                        
                        .tabViewStyle(.page)
                        .frame(width: proxy.size.width, height: 300)
                      
                        
                        VStack {
                            HStack(alignment: .top) {
                                AsyncImage(url: URL(string: game.coverURL ?? "")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 125, height: 187.5)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 10)
                                        )
                                        .offset(y: -25)
                                    
                                } placeholder: {
                                    Color.gray.opacity(0.0)
                                        .frame(width: 125, height: 187.5)
                                }
                                VStack {
                                    HStack {
                                        ZStack {
                                            ProgressView(value: game.rating, total: 100.0)
                                                .progressViewStyle(RatingProgressStyle(rating: Float(game.rating / 10)))
                                            Text("\(String(format: "%.1f", game.rating))")
                                        }
                                        Text("Rating")
                                            .font(.subheadline)
                                    }
                                    
                                    Text(game.name ?? "")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                    
                                    Text("\(formatDate(date: game.firstReleaseDate!))")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                 
                                  
                                }
                                .offset(y: -35)
                                .frame(width: 200)
                                .padding()
                                
                            }
                            VStack {
                                HStack {
                                    Text("Platforms")
                                        .padding(.leading)
                                        .font(.subheadline)
                                    Spacer()
                                }
                                
                            }
                            
                            LazyVGrid(columns: [.init(), .init()]) {
                                ForEach(game.platforms ?? [""], id: \.self) { platform in
                                    // create function to clean up the platform names
                                    
                                    PlatformCapsuleView(text: platformName(platform))

                                }
                            }
                            .padding(.horizontal)
                            
                            Divider()
                            
                            Section {
                                HStack {
                                    Text("Summary")
                                        .padding(.leading)
                                        .font(.subheadline)
                                    Spacer()
                                }
                                Text(game.summary ?? "No Summary available")
                                    .padding()
                                
                                Picker("Play Status", selection: $playStatus.onChange(update)) {
                                    ForEach(playStatuses, id: \.self) { status in
                                        Text(status)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .padding()
                                
                                if game.playStatus != "Not Played" {
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
                                                EditRatingView(rating: $userRating.onChange(update))
                                                    .padding(.top)
                                                
                                                TextEditor(text: $review.onChange(update))
                                                    .frame(width: 350)
                                                    .padding()
                                                
                                            }
                                        )
                                }
                                Spacer()
                            }
                        }
                    }
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
    
    func update() {
        game.objectWillChange.send()
        
        game.userRating = Int64(userRating)
        game.review = review
        game.playStatus = playStatus
        
        try? moc.save()
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d, yyyy")
        return dateFormatter.string(from: date)
    }
    
    func platformName(_ name: String) -> String {
        switch name {
        case "Nintendo GameCube":
            return "GameCube"
        case "Nintendo Entertainment System":
            return "NES"
        case "Super Nintendo Entertainment System":
            return "SNES"
        case "Xbox 360":
            return "X360"
        case "Xbox One" :
            return "XONE"
        case "Xbox Series X|S":
            return "Series X"
        case "Web browser":
            return "Web"
        case" PlayStation":
            return "PS1"
        case "PlayStation 2":
            return "PS2"
        case "PlayStation 3":
            return "PS3"
        case "PlayStation 4":
            return "PS4"
        case "PlayStation 5":
            return "PS5"
        case "PC (Microsoft Windows)":
            return "PC"
        case "Nintendo Switch":
            return "Switch"
        default:
            return name
        }
    }
}

struct SavedGameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SavedGameDetailView(game: CDGame.example)
    }
}
