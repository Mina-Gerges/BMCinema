//
//  MovieDetailsViewModelTests.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 18/03/2024.
//

import XCTest
@testable import BMCinema

class MovieDetailsViewModelTests: XCTestCase {

    // Test case for successful movie details fetching
    func testFetchMovieDetails_Success() {
        // **Given**

        let fetchUseCase = FetchMovieDetailsUseCase(repository: MockMovieDetailsRepoSuccess())
        let viewModel = MovieDetailsViewModel(movieId: "1", fetchMovieDetailsUseCase: fetchUseCase)
        let expectation = XCTestExpectation(description: "Movie details fetched successfully")
        XCTAssertEqual(viewModel.state, .loading)

        // **When**
        viewModel.fetchMovieDetails()
        

        // **Then**
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(viewModel.state, .success)
            XCTAssertNotNil(viewModel.movie)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    // Test case for error during movie details fetching
    func testFetchMovieDetailsNetworkError() {
        // **Given**
        let fetchUseCase = FetchMovieDetailsUseCase(repository: MockMovieDetailsRepoError(error: .network))
        let viewModel = MovieDetailsViewModel(movieId: "1", fetchMovieDetailsUseCase: fetchUseCase)
        let expectation = XCTestExpectation(description: "Fetch movie details network error")

        // **When**
        viewModel.fetchMovieDetails()

        // **Then**
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(viewModel.state, .error(message: NetworkError.network.errorDescription ?? ""))
            XCTAssertNil(viewModel.movie)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    // Test case for error during movie details fetching
    func testFetchMovieDetailsOtherError() {
        // **Given**
        let fetchUseCase = FetchMovieDetailsUseCase(repository: MockMovieDetailsRepoError(error: .invalidURL))
        let viewModel = MovieDetailsViewModel(movieId: "1", fetchMovieDetailsUseCase: fetchUseCase)
        let expectation = XCTestExpectation(description: "Fetch movie details other error")

        // **When**
        viewModel.fetchMovieDetails()

        // **Then**
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(viewModel.state, .error(message: NetworkError.invalidURL.errorDescription ?? ""))
            XCTAssertNil(viewModel.movie)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}
