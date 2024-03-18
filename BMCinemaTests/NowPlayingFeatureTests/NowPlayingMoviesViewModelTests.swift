//
//  NowPlayingMoviesViewModelTests.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 18/03/2024.
//

import XCTest
@testable import BMCinema

class NowPlayingMoviesViewModelTests: XCTestCase {
    var viewModel: NowPlayingMoviesViewModel!

    // MARK: - Tests
    func testFetchNowPlayingMoviesSuccess() {
        // **Given**

        let mockDataProvider = MockNowPlayingMovieRepoSuccess()
        viewModel = NowPlayingMoviesViewModel(
            fetchNowPlayingMoviesUseCase: FetchNowPlayingMoviesUseCase(
                repository: mockDataProvider
            )
        )

        // Set up expectations
        let expectation = XCTestExpectation(description: "Fetch NowPlaying movies")
        // Assert that the state is loading before fetching
        XCTAssertEqual(viewModel.state, .loading)
        XCTAssertEqual(viewModel.currentPage, 1)

        // **When**

        // Trigger the fetch method
        viewModel.fetchNowPlayingMovies()

        // **Then**

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            // Assert that the state is success
            XCTAssertEqual(self?.viewModel.state, .success)

            // Assert that NowPlaying movies are not empty
            XCTAssertFalse(self?.viewModel.nowPlayingMovies.isEmpty ?? true)

            // Assert that NowPlaying movies are not empty
            XCTAssertEqual(self?.viewModel.currentPage, 2)

            // Assert that the list can paginate
            XCTAssertEqual(self?.viewModel.canPaginate, true)

            // Assert that the number of movies in list = 3
            XCTAssertEqual(self?.viewModel.nowPlayingMovies.count, 3)

            // Fulfill expectation
            expectation.fulfill()
        }

        // WAIT FOR: expectations
        wait(for: [expectation], timeout: 3.0)
    }

    func testFetchNowPlayingMoviesNetworkError() {
        // **Given**

        // Set up expectations
        let expectation = XCTestExpectation(description: "Fetch NowPlaying movies network error")
        let mockDataProvider = MockNowPlayingMovieRepoError(error: .network)
        viewModel = NowPlayingMoviesViewModel(fetchNowPlayingMoviesUseCase: FetchNowPlayingMoviesUseCase(repository: mockDataProvider))

        // **When**

        // Trigger the fetch method
        viewModel.fetchNowPlayingMovies()

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

    func testFetchNowPlayingMoviesOtherError() {
        // **Given**

        // Set up expectations
        let expectation = XCTestExpectation(description: "Fetch NowPlaying movies other error")

        // Initialize the view model with the mock data provider
        let mockDataProvider = MockNowPlayingMovieRepoError(error: .invalidURL)
        viewModel = NowPlayingMoviesViewModel(fetchNowPlayingMoviesUseCase: FetchNowPlayingMoviesUseCase(repository: mockDataProvider))

        // **When**

        // Trigger the fetch method
        viewModel.fetchNowPlayingMovies()

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
