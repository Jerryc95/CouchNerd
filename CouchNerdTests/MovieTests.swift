//
//  MovieTests.swift
//  CouchNerdTests
//
//  Created by Jerry Cox on 8/25/22.
//

import XCTest
import CoreData

@testable import CouchNerd

class MovieTests: BaseTestCase {
    func testCreatingMovie() {
        let targetCount = 10
        
        for _ in 0..<targetCount {
            let movie = CDMovie(context: managedObjectContext)
        }
        
        XCTAssertEqual(try managedObjectContext.count(for: CDMovie.fetchRequest()), targetCount + 1)
    }
}
