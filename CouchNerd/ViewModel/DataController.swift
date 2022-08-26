//
//  DataController.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/23/22.
//

import CoreData
import Swift
import SwiftUI

class DataController: ObservableObject {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Main")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved Error \(error)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
