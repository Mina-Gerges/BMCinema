//
//  FetchNowPlayingMoviesUseCase.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

class FetchNowPlayingMoviesUseCase {
    let repository: NowPlayingMoviesRepoProtocol

    init(repository: NowPlayingMoviesRepoProtocol) {
        self.repository = repository
    }

    func fetchNowPlayingMovies(page: Int) async throws -> NowPlayingMoviesPaginatedModel {
        let entity = try await repository.fetchMovies(page: page)
        return NowPlayingMapper().mapToNowPlayingMoviesPaginatedModel(from: entity)
    }
}
