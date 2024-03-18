//
//  PopularMoviesUITests.swift
//  BMCinemaUITests
//
//  Created by Mina Hanna on 18/03/2024.
//

import XCTest

class PopularMoviesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testPopularMoviesTabbarNavigation() throws {
        let app = XCUIApplication()
        app.launch()

        // Navigate to the Upcoming tab
        let popularTab = app.tabBars.buttons["Popular"]
        XCTAssertTrue(popularTab.waitForExistence(timeout: 2))
        popularTab.tap()

        sleep(3)

        // Get the first cell in the table view
        let popularTable = app.tables.matching(identifier: "moviesTV")
        let cell = popularTable.cells.element(matching: .cell, identifier: "PopularMovieCell_1")
        XCTAssertTrue(cell.waitForExistence(timeout: 2))
    }
}
