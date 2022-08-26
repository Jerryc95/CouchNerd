//
//  FavoriteGamesView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/23/22.
//

import SwiftUI

struct FavoriteGamesView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
        SortDescriptor(\.userRating)
    ]) var games: FetchedResults<CDGame>
    
    var body: some View {
        List {
            ForEach(favoriteGames) { game in
                NavigationLink(destination: SavedGameDetailView(game: game)) {
                    ListItemView(imageLink: game.coverURL ?? "", title: game.name ?? "")
                }
            }
            .onDelete(perform: deleteItem)
        }
    }
    
    var favoriteGames: [CDGame] {
        return games.filter {$0.userRating == 5 }
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

struct FavoriteGamesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteGamesView()
    }
}
