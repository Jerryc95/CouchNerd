//
//  RatingView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/1/22.
//

import SwiftUI

struct EditRatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        if self.rating == number {
                            self.rating = 0
                        } else {
                            self.rating = number
                        }
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct EditRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EditRatingView(rating: .constant(3))
    }
}
