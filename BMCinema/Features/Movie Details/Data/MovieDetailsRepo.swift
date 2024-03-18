//
//  MovieDetailsRepo.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation

protocol MoviesDetailsRepoProtocol {
    func fetchMovie(withId id: String) async throws -> MovieEntity
}

class MovieDetailsRepo: MoviesDetailsRepoProtocol {
    let requestManager: RequestManager

    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }

    func fetchMovie(withId id: String) async throws -> MovieEntity {
        return try await requestManager.perform(MoviesRequests.fetchMovieDetailsWith(id: id))
    }
}
