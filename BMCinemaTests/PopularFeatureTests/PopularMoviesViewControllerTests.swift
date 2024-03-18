//
//  PopularMoviesViewControllerTests.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 18/03/2024.
//

import XCTest
@testable import BMCinema

class PopularMoviesViewControllerTests: XCTestCase {
    var sut: PopularMoviesViewController!
    var mockViewModel: PopularMoviesViewModel!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        // Create a mock view model and coordinator
        let fetchPopularMoviesUseCase = FetchPopularMoviesUseCase(
            repository: MockPopularMovieRepoSuccess()
        )
        mockViewModel = PopularMoviesViewModel(fetchPopularMoviesUseCase: fetchPopularMoviesUseCase)
        let mockCoordinator = PopularCoordinator()

        // Initialize the view controller with the mock view model and coordinator
        sut = PopularMoviesViewController(viewModel: mockViewModel, coordinator: mockCoordinator)

        // Load the view hierarchy
        sut.loadViewIfNeeded()
    }

    // MARK: - Tests
    func testViewControllerInitialState() {
        // Ensure that the view controller's initial state is set correctly
        XCTAssertEqual(sut.viewModel.state, .loading)
        XCTAssertNotNil(sut.moviesTV)
        XCTAssertNil(sut.emptyStateView.superview)
    }

    func testFetchPopularMoviesSuccess() {
        // **Given**

        // Set up expectations
        let expectation = XCTestExpectation(description: "Fetch Popular movies")

        // **When**

        // Trigger the fetch method
        sut.fetchMovies()

        // **Then**

        // Wait for the async call to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            // Assert that the view model's state is success
            XCTAssertEqual(self?.sut.viewModel.state, .success)

            // Assert that the movie table view is visible
            XCTAssertFalse(self?.sut.moviesTV?.isHidden ?? true)

            // Assert that the empty state view is not displayed
            XCTAssertNil(self?.sut.emptyStateView.superview)

            // Fulfill expectation
            expectation.fulfill()
        }

        // Wait for expectations
        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchPopularMoviesError() {
        // **Given**

        // Set up expectations
        let expectation = XCTestExpectation(description: "Fetch Popular movies error")

        // **When**

        // Initialize the view controller with a mock view model that raises a network error
        let fetchPopularMoviesUseCase = FetchPopularMoviesUseCase(repository: MockPopularMovieRepoError(error: .network))
        sut.viewModel = PopularMoviesViewModel(fetchPopularMoviesUseCase: fetchPopularMoviesUseCase)

        // Trigger the fetch method
        sut.fetchMovies()

        // **Then**

        // Wait for the async call to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            // Assert that the view model's state is error
            XCTAssertEqual(self?.sut.viewModel.state, .error(message: NetworkError.network.errorDescription ?? ""))

            // Assert that the empty state view is displayed
            XCTAssertNotNil(self?.sut.emptyStateView.superview)

            // Fulfill expectation
            expectation.fulfill()
        }

        // Wait for expectations
        wait(for: [expectation], timeout: 2.0)
    }
}
