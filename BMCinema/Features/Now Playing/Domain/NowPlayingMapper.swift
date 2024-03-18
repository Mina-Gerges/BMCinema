//
//  NowPlayingMapper.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

class NowPlayingMapper {
    func mapToNowPlayingMoviesPaginatedModel(from entity: MoviesPaginatedEntity) -> NowPlayingMoviesPaginatedModel {
        let dates = entity.dates
        let page = entity.page
        let totalPages = entity.totalPages
        let totalResults = entity.totalResults
        let movies = entity.results?.map { mapToNowPlayingMovie(from: $0) }
        return NowPlayingMoviesPaginatedModel(dates: dates, page: page, movies: movies, totalPages: totalPages, totalResults: totalResults)
    }

    func mapToNowPlayingMovie(from entity: MovieEntity) -> NowPlayingMovie {
        return NowPlayingMovie(id: entity.id,
                               overview: entity.overview,
                               posterPath: entity.posterPath,
                               title: entity.title,
                               voteAverage: entity.voteAverage,
                               voteCount: entity.voteCount)
    }
}
