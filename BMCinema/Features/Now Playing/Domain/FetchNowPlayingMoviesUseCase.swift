//
//  FetchNowPlayingMoviesUseCase.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

class FetchNowPlayingMoviesUseCase {
    let repository: NowPlayingMoviesRepoProtocol
    let dbService = DatabaseService.shared

    init(repository: NowPlayingMoviesRepoProtocol) {
        self.repository = repository
    }

    func fetchNowPlayingMovies(page: Int) async throws -> NowPlayingMoviesPaginatedModel {
//        do {
            let entity = try await repository.fetchMovies(page: page)
            let nowPlayingMoviesPaginatedModel = NowPlayingMapper().mapToNowPlayingMoviesPaginatedModel(from: entity)

//            // Save movies in the background
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
//                let movies = nowPlayingMoviesPaginatedModel.movies
//                movies?.forEach { self?.dbService.save(nowPlayingMovie: $0) }
//            }
            return nowPlayingMoviesPaginatedModel
//        } catch {
//            // Retrieve movies from SwiftData in case of any failure.
//            let movies = try await dbService.fetchNowPlayingMoviesPaginatedModel()
//            guard (movies.count > 0) && (page == 1) else { throw error }
//            return NowPlayingMoviesPaginatedModel(dates: nil, page: 1, movies: movies, totalPages: nil, totalResults: nil)
//        }
    }
}
