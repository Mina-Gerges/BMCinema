//
//  MovieDetailMapper.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import Foundation

class MovieDetailsMapper {
    func mapToMovieDetails(from entity: MovieEntity) -> MovieDetailsModel {
        let genres = entity.genres?.compactMap { genreEntity in
            return mapToMovieGenreModel(from: genreEntity)
        }
        return MovieDetailsModel(genres: genres,
                            homepage: entity.homepage,
                            id: entity.id,
                            imdbId: entity.imdbId,
                            originalLanguage: entity.originalLanguage,
                            originalTitle: entity.originalTitle,
                            overview: entity.overview,
                            popularity: entity.popularity,
                            posterPath: entity.posterPath,
                            releaseDate: entity.releaseDate,
                            status: entity.status,
                            tagline: entity.tagline,
                            title: entity.title,
                            voteAverage: entity.voteAverage,
                            voteCount: entity.voteCount)
    }

    func mapToMovieGenreModel(from entity: GenreEntity) -> MovieGenreModel {
        return MovieGenreModel(id: entity.id, name: entity.name)
    }
}
