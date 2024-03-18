//
//  FetchPopularMoviesUseCase.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

class FetchPopularMoviesUseCase {
    let repository: PopularMoviesRepoProtocol

    init(repository: PopularMoviesRepoProtocol) {
        self.repository = repository
    }

    func fetchPopularMovies(page: Int) async throws -> PopularMoviesPaginatedModel {
        let entity = try await repository.fetchMovies(page: page)
        return PopularMapper().mapToPopularMoviesPaginatedModel(from: entity)
    }
}
