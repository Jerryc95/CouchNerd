//
//  DiscoverView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/28/22.
//

import SwiftUI

struct DiscoverView: View {
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
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 50)
                        .foregroundColor(Color.secondarySystemGroupedBackground)
                    HStack {
                        iconColor
                            .frame(width: 40)
                            .mask {
                                Image(systemName: icon)
                                    .font(.system(size: 22))
                            }
                        Text(title)
                            .bold()
                            .font(.title3)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }

        
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(icon: "play.circle", iconColor: GradientColors().tvGradient, title: "TV & Anime", destination: TVSearchView())
    }
}
