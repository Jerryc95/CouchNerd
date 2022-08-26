//
//  FavoriteTVShowsView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/23/22.
//

import SwiftUI

struct FavoriteTVShowsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
        SortDescriptor(\.rating)
    ]) var tvShows: FetchedResults<CDTVShow>
    
    var body: some View {
        List {
            ForEach(favoriteShows) { show in
                NavigationLink(destination: SavedTVShowDetailView(tvShow: show)) {
                    ListItemView(imageLink: show.posterPath ?? "", title: show.name ?? "")
                }
            }
            .onDelete(perform: deleteItem)
        }

    }
    var favoriteShows: [CDTVShow] {
        return tvShows.filter {$0.rating == 5 }
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let tvShow = tvShows[index]
            moc.delete(tvShow)
        }
        do {
            try moc.save()
        } catch {
            print("error: \(error)")
        }
    }
}

struct FavoriteTVShowsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteTVShowsView()
    }
}
