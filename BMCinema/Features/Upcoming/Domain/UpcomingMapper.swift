//
//  UpcomingMapper.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

class UpcomingMapper {
    func mapToUpcomingMoviesPaginatedModel(from entity: MoviesPaginatedEntity) -> UpcomingMoviesPaginatedModel {
        let dates = entity.dates
        let page = entity.page
        let totalPages = entity.totalPages
        let totalResults = entity.totalResults
        let movies = entity.results?.map { mapToUpcomingMovie(from: $0) }
        return UpcomingMoviesPaginatedModel(dates: dates, page: page, movies: movies, totalPages: totalPages, totalResults: totalResults)
    }

    func mapToUpcomingMovie(from entity: MovieEntity) -> UpcomingMovie {
        return UpcomingMovie(id: entity.id,
                             overview: entity.overview,
                             posterPath: entity.posterPath,
                             releaseDate: entity.releaseDate,
                             title: entity.title)
    }
}
