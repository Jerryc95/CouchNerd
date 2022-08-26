//
//  SavedView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/24/22.
//

import SwiftUI

struct SavedView: View {
    @Environment(\.colorScheme) var colorScheme
    
    
    
    var icon: String
    var iconColor: LinearGradient
    var title: String
    var destination: AnyView
    
    init<V>(icon: String, iconColor: LinearGradient, title: String,  destination: V) where V: View {
        self.iconColor = iconColor
        self.icon = icon
        self.title = title
        self.destination = AnyView(destination)
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
    
                GroupBox(label: Label(title, systemImage: icon)) {
                    Text("")
                }
                .groupBoxStyle(SystemGroupBoxStyle(color: iconColor))
        }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView(icon: "play.circle", iconColor: GradientColors().movieGradient, title: "Movies", destination: SavedMoviesView())
    }
}
