//
//  FetchMovieDetailsUseCase.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation

class FetchMovieDetailsUseCase {
    let repository: MoviesDetailsRepoProtocol

    init(repository: MoviesDetailsRepoProtocol) {
        self.repository = repository
    }

    func fetchMovieDetails(withId id: String) async throws -> MovieDetailsModel {
        let entity = try await repository.fetchMovie(withId: id)
        return MovieDetailsMapper().mapToMovieDetails(from: entity)
    }
}
