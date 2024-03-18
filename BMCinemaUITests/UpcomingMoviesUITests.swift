//
//  UpcomingMoviesUITests.swift
//  BMCinemaUITests
//
//  Created by Mina Hanna on 18/03/2024.
//

import XCTest

class UpcomingMoviesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testUpcomingMoviesTabbarNavigation() throws {
        let app = XCUIApplication()
        app.launch()

        // Navigate to the Upcoming tab
        let upcomingTab = app.tabBars.buttons["Upcoming"]
        XCTAssertTrue(upcomingTab.waitForExistence(timeout: 2))
        upcomingTab.tap()

        sleep(3)

        // Get the first cell in the table view
        let upcomingTable = app.tables.matching(identifier: "moviesTV")
        let cell = upcomingTable.cells.element(matching: .cell, identifier: "UpcomingMovieCell_1")
        XCTAssertTrue(cell.waitForExistence(timeout: 2))
    }
}
