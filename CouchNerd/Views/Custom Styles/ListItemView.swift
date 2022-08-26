//
//  ListItemView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/22/22.
//

import SwiftUI

struct ListItemView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var imageLink: String
    var title: String
    var chevron: String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 130)
                .foregroundColor(Color.secondarySystemGroupedBackground)
            HStack {
                AsyncImage(url: URL(string: imageLink)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 112.5)
                } placeholder: {
                    Color.gray.opacity(0.0)
                        .frame(width: 75, height: 112.5)
                }
                Text(title)
                    .bold()
                    .font(.title3)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                Spacer()
                
                Image(systemName: chevron ?? "")
                    .foregroundColor(.secondary)
            }
            .padding()
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(imageLink: "", title: "")
    }
}
