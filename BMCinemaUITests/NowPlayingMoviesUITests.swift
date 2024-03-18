//
//  NowPlayingMoviesUITests.swift
//  BMCinemaUITests
//
//  Created by Mina Hanna on 18/03/2024.
//

import XCTest

class NowPlayingMoviesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testNowPlayingMoviesTabbarNavigation() throws {
        let app = XCUIApplication()
        app.launch()

        // Navigate to the Upcoming tab
        let nowPlayingTab = app.tabBars.buttons["Now Playing"]
        XCTAssertTrue(nowPlayingTab.waitForExistence(timeout: 2))
        nowPlayingTab.tap()

        sleep(3)

        // Get the first cell in the table view
        let nowPlayingTable = app.tables.matching(identifier: "moviesTV")
        let cell = nowPlayingTable.cells.element(matching: .cell, identifier: "NowPlayingMovieCell_1")
        XCTAssertTrue(cell.waitForExistence(timeout: 2))
    }
}
