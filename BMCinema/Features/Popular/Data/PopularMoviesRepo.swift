//
//  PopularMoviesRepo.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

protocol PopularMoviesRepoProtocol {
    func fetchMovies(page: Int) async throws -> MoviesPaginatedEntity
}

class PopularMoviesRepo: PopularMoviesRepoProtocol {
    let requestManager: RequestManager

    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }

    func fetchMovies(page: Int) async throws -> MoviesPaginatedEntity {
        try await requestManager.perform(MoviesRequests.fetchPopularMoviesFor(page: page))
    }
}
