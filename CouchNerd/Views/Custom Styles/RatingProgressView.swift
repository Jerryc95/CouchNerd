//
//  RatingProgressView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/26/22.
//

import SwiftUI

struct RatingProgressStyle: ProgressViewStyle {
    let rating: Float
    var strokeColor: Color {
        switch rating {
        case 0.0...2.9:
            return .red
        case 4.0...6.9:
            return .orange
        case 7.0...10:
            return .green
        default:
            return .clear
        }
    }
    var strokeWidth = 2.5

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: 45)
        }
    }
}

struct RatingProgressView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RatingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        RatingProgressView()
    }
}
