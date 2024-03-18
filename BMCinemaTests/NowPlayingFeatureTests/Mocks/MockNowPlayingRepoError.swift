//
//  MockNowPlayingRepoError.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 18/03/2024.
//

import Foundation
@testable import BMCinema

/// Mock NowPlaying different types of errors
class MockNowPlayingMovieRepoError: NowPlayingMoviesRepoProtocol {
    let error: NetworkError

    init(error: NetworkError) {
        self.error = error
    }

    func fetchMovies(page: Int) async throws -> BMCinema.MoviesPaginatedEntity {
        throw error
    }
}
