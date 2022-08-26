//
//  SavedGameView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/18/22.
//

import SwiftUI

struct SavedGameView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var games: FetchedResults<CDGame>
    
   
    @State private var selectedStatus = "Not Played"
    @State private var playStatuses = ["Not Played", "Playing", "Finished"]
    
    var body: some View {
        VStack {
            Picker("Play Status", selection: $selectedStatus) {
                ForEach(playStatuses, id: \.self) { status in
                    Text(status)
                }
            }
            .padding([.leading, .trailing])
            .pickerStyle(.segmented)
            
            List {
                ForEach(filteredGames) { game in
                    NavigationLink(destination: SavedGameDetailView(game: game)) {
                        HStack {
                            AsyncImage(url: URL(string: game.coverURL ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 112.5)
                            } placeholder: {
                                Color.gray.opacity(0.0)
                                    .frame(width: 75, height: 112.5)
                            }
                            Text(game.name ?? "")
                                .bold()
                                .font(.title3)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                        }
                        .padding()
                    }
                }
                .onDelete(perform: deleteItem)
            }
        }
         .background(Color.systemGroupedBackground)
        .navigationTitle("Games")
        .toolbar {
            EditButton()
        }
    }
    
    var filteredGames: [CDGame] {
        switch selectedStatus {
        case "Not Played":
            return games.filter {$0.playStatus == "Not Played" }
            
        case "Playing":
            return games.filter {$0.playStatus == "Playing" }
            
        case "Finished":
            return games.filter {$0.playStatus == "Finished" }
        default:
            break
        }
        return []
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let game = games[index]
            moc.delete(game)
        }
        do {
            try moc.save()
        } catch {
            print("error: \(error)")
        }
    }
}

struct SavedGameView_Previews: PreviewProvider {
    static var previews: some View {
        SavedGameView()
    }
}
