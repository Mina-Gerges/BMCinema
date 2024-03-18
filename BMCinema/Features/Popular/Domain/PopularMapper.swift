//
//  PopularMapper.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

class PopularMapper {
    func mapToPopularMoviesPaginatedModel(from entity: MoviesPaginatedEntity) -> PopularMoviesPaginatedModel {
        let dates = entity.dates
        let page = entity.page
        let totalPages = entity.totalPages
        let totalResults = entity.totalResults
        let movies = entity.results?.map { mapToPopularMovie(from: $0) }
        return PopularMoviesPaginatedModel(dates: dates, page: page, movies: movies, totalPages: totalPages, totalResults: totalResults)
    }

    func mapToPopularMovie(from entity: MovieEntity) -> PopularMovie {
        return PopularMovie(id: entity.id,
                            overview: entity.overview,
                            popularity: entity.popularity,
                            posterPath: entity.posterPath,
                            title: entity.title,
                            voteAverage: entity.voteAverage,
                            voteCount: entity.voteCount)
    }
}
