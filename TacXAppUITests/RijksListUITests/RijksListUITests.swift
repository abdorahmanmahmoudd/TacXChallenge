//
//  RijksListUITests.swift
//  TacXAppUITests
//
//  Created by Abdelrahman Ali on 26/09/2020.
//

import XCTest

class RijksListUITests: XCTestCase {
    
    // Test RijksListTableView exists and has 10 cells
    func testRijksListCells() {
        // Given
        let app = XCUIApplication()
        
        // When
        app.launch()
        
        // Then
        XCTAssert(app.tables[AccessibilityIdentifiers.rijksListTableView.rawValue].cells.count == 10)
    }

}
