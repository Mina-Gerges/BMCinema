//
//  MoviesRepo.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation

protocol UpcomingMoviesRepoProtocol {
    func fetchMovies(page: Int) async throws -> MoviesPaginatedEntity
}

class UpcomingMoviesRepo: UpcomingMoviesRepoProtocol {
    let requestManager: RequestManager

    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }

    func fetchMovies(page: Int) async throws -> MoviesPaginatedEntity {
        try await requestManager.perform(MoviesRequests.fetchUpcomingMoviesFor(page: page))
    }
}
