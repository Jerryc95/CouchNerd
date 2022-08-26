//
//  SettingsView.swift
//  CouchNerd
//
//  Created by Jerry Cox on 8/22/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Section WIP")
                .font(.title)
                .foregroundColor(.red)
            Form {
                Section("General") {
                    Text("Appearance")
                    Text("Text Size")
                    Text("App Icon")
                }
                
                Section {
                    NavigationLink(destination: AboutView()) {
                        Text("About")
                    }
                    Text("Tip Jar")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
