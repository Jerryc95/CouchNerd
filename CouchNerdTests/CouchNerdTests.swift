//
//  CouchNerdTests.swift
//  CouchNerdTests
//
//  Created by Jerry Cox on 8/25/22.
//

import XCTest
import CoreData

@testable import CouchNerd

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        dataController = DataController()
        managedObjectContext = dataController.container.viewContext
    }

}
