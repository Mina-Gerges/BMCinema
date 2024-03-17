//
//  FetchUpcomingMoviesUseCase.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation

class FetchUpcomingMoviesUseCase {
    let repository: UpcomingMoviesRepoProtocol

    init(repository: UpcomingMoviesRepoProtocol) {
        self.repository = repository
    }

    func fetchUpcomingMovies(page: Int) async throws -> UpcomingMoviesPaginatedModel {
        let entity = try await repository.fetchMovies(page: page)
        return UpcomingMapper().mapToUpcomingMoviesPaginatedModel(from: entity)
    }
}
