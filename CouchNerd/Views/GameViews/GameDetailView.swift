//
//  GameDetailView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/11/22.
//

import SwiftUI

struct GameDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var gameNetworker: GameNetworker
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.id)
    ]) var games: FetchedResults<CDGame>
    
    @State private var showAlert = false
    @State private var isAddingGame = false
    
    var game: Game

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ZStack {
                    VStack {
                        TabView {
                            ForEach(game.screenshotURLs, id: \.self) { url in
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
                                AsyncImage(url: URL(string: game.coverURL)) { image in
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
                                    
                                    Text(game.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                    
                                    Text("\(formatDate(date: game.firstReleaseDate))")
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
                                ForEach(game.platforms, id: \.self) { platform in
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
                                Text(game.summary)
                                    .padding()
                            }
                            
                            Spacer()
                            Button(action: {
                                if games.contains(where: { $0.id == game.id }) {
                                    showAlert = true
                                } else {
                                    isAddingGame = true
                                }
                            }, label: {
                                Text("Add to List")
                            })
                            .buttonStyle(AddButtonStyle(gradient: GradientColors().gameGradient))
                            
                        }
                    }
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $isAddingGame, content: {
            AddGameView(game: game)
        })
        .alert("Game already added to list", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }

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

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(game: Game.example)
    }
}
