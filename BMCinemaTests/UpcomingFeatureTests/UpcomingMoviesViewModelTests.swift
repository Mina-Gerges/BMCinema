//
//  UpcomingMoviesViewModelTests.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 17/03/2024.
//

import XCTest
@testable import BMCinema

class UpcomingMoviesViewModelTests: XCTestCase {
    var viewModel: UpcomingMoviesViewModel!

    // MARK: - Tests
    func testFetchUpcomingMoviesSuccess() {
        // **Given**

        let mockDataProvider = MockUpcomingMovieRepoSuccess()
        viewModel = UpcomingMoviesViewModel(
            fetchUpcomingMoviesUseCase: FetchUpcomingMoviesUseCase(
                repository: mockDataProvider
            )
        )

        // Set up expectations
        let expectation = XCTestExpectation(description: "Fetch upcoming movies")
        // Assert that the state is loading before fetching
        XCTAssertEqual(viewModel.state, .loading)
        XCTAssertEqual(viewModel.currentPage, 1)

        // **When**

        // Trigger the fetch method
        viewModel.fetchUpcomingMovies()

        // **Then**

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            // Assert that the state is success
            XCTAssertEqual(self?.viewModel.state, .success)

            // Assert that upcoming movies are not empty
            XCTAssertFalse(self?.viewModel.upcomingMovies.isEmpty ?? true)

            // Assert that upcoming movies are not empty
            XCTAssertEqual(self?.viewModel.currentPage, 2)

            // Assert that the list can paginate
            XCTAssertEqual(self?.viewModel.canPaginate, true)

            // Assert that the number of movies in list = 3
            XCTAssertEqual(self?.viewModel.upcomingMovies.count, 3)

            // Fulfill expectation
            expectation.fulfill()
        }

        // WAIT FOR: expectations
        wait(for: [expectation], timeout: 3.0)
    }

    func testFetchUpcomingMoviesNetworkError() {
        // **Given**

        // Set up expectations
        let expectation = XCTestExpectation(description: "Fetch upcoming movies network error")
        let mockDataProvider = MockUpcomingMovieRepoError(error: .network)
        viewModel = UpcomingMoviesViewModel(fetchUpcomingMoviesUseCase: FetchUpcomingMoviesUseCase(repository: mockDataProvider))

        // **When**

        // Trigger the fetch method
        viewModel.fetchUpcomingMovies()

        // **Then**

        // Wait for the async call to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            // Assert that the state is error with network error message
            XCTAssertEqual(self?.viewModel.state, .error(message: NetworkError.network.errorDescription ?? ""))

            // Fulfill expectation
            expectation.fulfill()
        }

        // Wait for expectations
        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchUpcomingMoviesOtherError() {
        // **Given**

        // Set up expectations
        let expectation = XCTestExpectation(description: "Fetch upcoming movies other error")

        // Initialize the view model with the mock data provider
        let mockDataProvider = MockUpcomingMovieRepoError(error: .invalidURL)
        viewModel = UpcomingMoviesViewModel(fetchUpcomingMoviesUseCase: FetchUpcomingMoviesUseCase(repository: mockDataProvider))

        // **When**

        // Trigger the fetch method
        viewModel.fetchUpcomingMovies()

        // **Then**

        // Wait for the async call to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            // Assert that the state is error with other error message
            XCTAssertEqual(self?.viewModel.state, .error(message: NetworkError.invalidURL.errorDescription ?? ""))

            // Fulfill expectation
            expectation.fulfill()
        }

        // Wait for expectations
        wait(for: [expectation], timeout: 2.0)
    }

}
