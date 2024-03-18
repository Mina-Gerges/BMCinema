//
//  MovieDetails.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation

struct MovieDetailsModel {
    let genres: [MovieGenreModel]?
    let homepage: String?
    let id: Int?
    let imdbId: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let status: String?
    let tagline: String?
    let title: String?
    let voteAverage: Double?
    let voteCount: Int?

    /// Image Poster full path
    var posterImagePath: String? {
      AppConstants.imageBaseUrl + (posterPath ?? "")
    }
}
