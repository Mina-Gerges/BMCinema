//
//  PopularMoviesViewModelTests.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 18/03/2024.
//

import XCTest
@testable import BMCinema

class PopularMoviesViewModelTests: XCTestCase {
    var viewModel: PopularMoviesViewModel!

    // MARK: - Tests
    func testFetchPopularMoviesSuccess() {
        // **Given**

        let mockDataProvider = MockPopularMovieRepoSuccess()
        viewModel = PopularMoviesViewModel(
            fetchPopularMoviesUseCase: FetchPopularMoviesUseCase(
                repository: mockDataProvider
            )
        )

        // Set up expectations
        let expectation = XCTestExpectation(description: "Fetch Popular movies")
        // Assert that the state is loading before fetching
        XCTAssertEqual(viewModel.state, .loading)
        XCTAssertEqual(viewModel.currentPage, 1)

        // **When**

        // Trigger the fetch method
        viewModel.fetchPopularMovies()

        // **Then**

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            // Assert that the state is success
            XCTAssertEqual(self?.viewModel.state, .success)

            // Assert that Popular movies are not empty
            XCTAssertFalse(self?.viewModel.popularMovies.isEmpty ?? true)

            // Assert that Popular movies are not empty
            XCTAssertEqual(self?.viewModel.currentPage, 2)

            // Assert that the list can paginate
            XCTAssertEqual(self?.viewModel.canPaginate, true)

            // Assert that the number of movies in list = 3
            XCTAssertEqual(self?.viewModel.popularMovies.count, 3)

            // Fulfill expectation
            expectation.fulfill()
        }

        // WAIT FOR: expectations
        wait(for: [expectation], timeout: 3.0)
    }

    func testFetchPopularMoviesNetworkError() {
        // **Given**

        // Set up expectations
        let expectation = XCTestExpectation(description: "Fetch Popular movies network error")
        let mockDataProvider = MockPopularMovieRepoError(error: .network)
        viewModel = PopularMoviesViewModel(fetchPopularMoviesUseCase: FetchPopularMoviesUseCase(repository: mockDataProvider))

        // **When**

        // Trigger the fetch method
        viewModel.fetchPopularMovies()

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

    func testFetchPopularMoviesOtherError() {
        // **Given**

        // Set up expectations
        let expectation = XCTestExpectation(description: "Fetch Popular movies other error")

        // Initialize the view model with the mock data provider
        let mockDataProvider = MockPopularMovieRepoError(error: .invalidURL)
        viewModel = PopularMoviesViewModel(fetchPopularMoviesUseCase: FetchPopularMoviesUseCase(repository: mockDataProvider))

        // **When**

        // Trigger the fetch method
        viewModel.fetchPopularMovies()

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
