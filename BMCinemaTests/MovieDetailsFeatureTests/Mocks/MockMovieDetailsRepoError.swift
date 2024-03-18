//
//  MockMovieDetailsRepoError.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 18/03/2024.
//

import Foundation
@testable import BMCinema

/// Mock Movie Details different types of errors
class MockMovieDetailsRepoError: MoviesDetailsRepoProtocol {
    let error: NetworkError

    init(error: NetworkError) {
        self.error = error
    }

    func fetchMovie(withId movieId: String) async throws -> BMCinema.MovieEntity {
        throw error
    }
}
