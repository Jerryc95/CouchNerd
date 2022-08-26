//
//  StringHelper.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/24/22.
//

import Foundation

extension String {
    func removeSpace(_ text: String) -> String {
        if text.contains(" ") {
            let newText = text.replacingOccurrences(of: " ", with: "%20")
            return newText
        }
       return text
    }
    
    
}
