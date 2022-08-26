//
//  PlatformCapsuleView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/18/22.
//

import SwiftUI

struct PlatformCapsuleView: View {
    let text: String
    
    var body: some View {
        Capsule()
        .foregroundColor(.clear)
        .frame(height: 40)
        .background(
            GradientColors().gameGradient
        )
        .clipShape(Capsule())
        .overlay {
            Text(text)
                .foregroundColor(.white)
                
        }
        
    }
}

struct PlatformCapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformCapsuleView(text: "")
    }
}
