//
//  SavedMoviesView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/1/22.
//

import SwiftUI

struct SavedMoviesView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title)
    ]) var movies: FetchedResults<CDMovie>
    
    
    @State private var selectedStatus = "Unwatched"
    @State private var watchStatuses = ["Unwatched", "Watched"]
    
    var body: some View {
        VStack {
            Picker("Watch Status", selection: $selectedStatus) {
                ForEach(watchStatuses, id: \.self) { status in
                    Text(status)
                }
            }
            .padding([.leading, .trailing])
            .pickerStyle(.segmented)
            
            List {
                ForEach(filteredMovie) { movie in
                    NavigationLink(destination: SavedMovieDetailView(movie: movie)) {
                        HStack {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 112.5)
                            } placeholder: {
                                Color.gray.opacity(0.0)
                                    .frame(width: 75, height: 112.5)
                            }
                            Text(movie.title ?? "")
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
        .navigationTitle("Movies")
        .toolbar {
            EditButton()
        }
    }
    
    var filteredMovie: [CDMovie] {
        switch selectedStatus {
        case "Unwatched":
            return movies.filter { $0.watchStatus == "Unwatched" }
        case "Watched":
            return movies.filter { $0.watchStatus == "Watched" }
        default:
            break
        }
        return []
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

struct SavedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedMoviesView()
    }
}
