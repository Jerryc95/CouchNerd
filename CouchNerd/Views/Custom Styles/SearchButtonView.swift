//
//  SearchButtonStyle.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/27/22.
//

import SwiftUI

struct SearchButtonStyle: ButtonStyle {
    let gradient: LinearGradient
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 75, height: 50)
            .background(
                gradient
            )
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .foregroundColor(.white)
            .overlay(
                Color.black
                .opacity(configuration.isPressed ? 0.3 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            )
        
    }
}

struct SearchButtonView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SearchButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SearchButtonView()
    }
}
