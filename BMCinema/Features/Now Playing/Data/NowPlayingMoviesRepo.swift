//
//  NowPlayingMoviesRepo.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

protocol NowPlayingMoviesRepoProtocol {
    func fetchMovies(page: Int) async throws -> MoviesPaginatedEntity
}

class NowPlayingMoviesRepo: NowPlayingMoviesRepoProtocol {
    let requestManager: RequestManager

    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }

    func fetchMovies(page: Int) async throws -> MoviesPaginatedEntity {
        try await requestManager.perform(MoviesRequests.fetchNowPlayingMoviesFor(page: page))
    }
}
