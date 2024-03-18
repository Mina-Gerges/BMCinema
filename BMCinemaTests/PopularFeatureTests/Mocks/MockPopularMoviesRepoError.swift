//
//  MockPopularMoviesRepoError.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 18/03/2024.
//

import Foundation
@testable import BMCinema

/// Mock Popular different types of errors
class MockPopularMovieRepoError: PopularMoviesRepoProtocol {
    let error: NetworkError

    init(error: NetworkError) {
        self.error = error
    }

    func fetchMovies(page: Int) async throws -> BMCinema.MoviesPaginatedEntity {
        throw error
    }
}
