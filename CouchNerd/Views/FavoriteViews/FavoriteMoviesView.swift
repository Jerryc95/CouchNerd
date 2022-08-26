//
//  FavoriteMoviesView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/23/22.
//

import SwiftUI

struct FavoriteMoviesView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.rating)
    ]) var movies: FetchedResults<CDMovie>
    
    var body: some View {
        List {
            ForEach(favoriteMovies) { movie in
                NavigationLink(destination: SavedMovieDetailView(movie: movie)) {
                    ListItemView(imageLink: movie.posterPath ?? "", title: movie.title ?? "")
                }
            }
            .onDelete(perform: deleteItem)
        }
    }
    var favoriteMovies: [CDMovie] {
        return movies.filter {$0.rating == 5 }
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let movie = movies[index]
            moc.delete(movie)
        }
        do {
            try moc.save()
        } catch {
            print("error: \(error)")
        }
    }
}

struct FavoriteMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesView()
    }
}
