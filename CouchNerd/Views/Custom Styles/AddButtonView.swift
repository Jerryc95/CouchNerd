//
//  AddButtonView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/27/22.
//

import SwiftUI


struct AddButtonStyle: ButtonStyle {
    let gradient: LinearGradient
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal, 50)
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

struct AddButtonView: View {
    var body: some View {
       Text("Hello, World")
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView()
    }
}
