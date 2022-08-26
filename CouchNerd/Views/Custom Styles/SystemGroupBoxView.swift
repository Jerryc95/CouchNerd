//
//  SystemGroupBoxView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/28/22.
//

import SwiftUI

struct SystemGroupBoxStyle: GroupBoxStyle {
    let font = Font.system(size: 18, weight: .semibold)
    var color: LinearGradient
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .frame(maxWidth: .infinity, minHeight: 50)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill((color)))
            .overlay(
                configuration.label
                    .font(font)
                    .padding(.leading), alignment: .leading
            )
    }
}

struct SystemGroupBoxView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct SystemGroupBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SystemGroupBoxView()
    }
}
