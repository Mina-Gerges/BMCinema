//
//  MockUpcomingMovieRepoError.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation
@testable import BMCinema

/// Mock Upcoming different types of errors
class MockUpcomingMovieRepoError: UpcomingMoviesRepoProtocol {
    let error: NetworkError

    init(error: NetworkError) {
        self.error = error
    }
    
    func fetchMovies(page: Int) async throws -> BMCinema.MoviesPaginatedEntity {
        throw error
    }
}
