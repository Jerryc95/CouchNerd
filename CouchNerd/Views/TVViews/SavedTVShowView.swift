//
//  SavedTVShowView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/16/22.
//

import SwiftUI

struct SavedTVShowView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var tvShows: FetchedResults<CDTVShow>
    
    @State private var selectedStatus = "Unwatched"
    @State private var watchStatuses = ["Unwatched", "Watching", "Waiting", "Finished"]
    
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
                ForEach(filteredTVShow) { show in
                    NavigationLink(destination: SavedTVShowDetailView(tvShow: show)) {
                        HStack {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(show.posterPath ?? "")")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 112.5)
                            } placeholder: {
                                Color.gray.opacity(0.0)
                                    .frame(width: 75, height: 112.5)
                            }
                            Text(show.name ?? "")
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
        .navigationTitle("TV & Anime")
        .toolbar {
            EditButton()
        }
    }
    var filteredTVShow: [CDTVShow] {
        switch selectedStatus {
        case "Unwatched":
            return tvShows.filter {$0.watchStatus == "Unwatched" }
            
        case "Watching":
            return tvShows.filter {$0.watchStatus == "Watching" }
            
        case "Waiting":
            return tvShows.filter {$0.watchStatus == "Waiting" }
            
        case "Finished":
            return tvShows.filter {$0.watchStatus == "Finished" }
        default:
            break
        }
        return []
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

struct SavedTVShowView_Previews: PreviewProvider {
    static var previews: some View {
        SavedTVShowView()
    }
}
