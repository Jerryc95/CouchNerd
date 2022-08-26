//
//  GradientColorHelper.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/28/22.
//

import SwiftUI

struct GradientColors {
    let tvGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 249/255, green: 119/255, blue: 148/255), Color(red: 98/255, green: 58/255, blue: 162/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let movieGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 252/255, green: 207/255, blue: 49/255), Color(red: 245/255, green: 85/255, blue: 85/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let favoriteGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 255/255, green: 226/255, blue: 89/255), Color(red: 255/255, green: 167/255, blue: 81/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let gameGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 151/255, green: 171/255, blue: 255/255), Color(red: 18/255, green: 53/255, blue: 151/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)

}
