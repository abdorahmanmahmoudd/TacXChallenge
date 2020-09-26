//
//  ArtDetailsUITests.swift
//  TacXAppUITests
//
//  Created by Abdelrahman Ali on 26/09/2020.
//

import XCTest

class ArtDetailsUITests: XCTestCase {
    

    // Test ArtDetailsView filled correctly
    func testSelectedArtDetailsFilling() {
        
        // Given
        let app = XCUIApplication()
        
        app.launchEnvironment = [Constants.UITesting.uiTestingRunning: "0"]
        app.launch()

        let table = app.tables[AccessibilityIdentifiers.rijksListTableView.rawValue]
        XCTAssertTrue(table.exists, "Arts Table exists")

        // When
        table.cells.containing(.staticText, identifier: "Zelfportret").staticTexts["Zelfportret"].tap()
                
        // Then
        XCTAssertEqual(app.staticTexts[AccessibilityIdentifiers.detailsArtTitle.rawValue].label, "Zelfportret, Rembrandt van Rijn, ca. 1628")
        XCTAssertEqual(app.staticTexts[AccessibilityIdentifiers.detailsArtMaker.rawValue].label, "Rembrandt van Rijn")
        XCTAssertEqual(app.staticTexts[AccessibilityIdentifiers.detailsArtDate.rawValue].label, "ca. 1628")
        XCTAssertEqual(app.staticTexts[AccessibilityIdentifiers.detailsArtDescription.rawValue].label, "Zelfportret van Rembrandt op jeugdige leeftijd. Buste naar rechts, het gelaat in de schaduw, met krullend haar.")
    }

}
