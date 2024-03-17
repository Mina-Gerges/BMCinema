//
//  MovieEntity.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

struct MovieEntity: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [GenreEntity]?
    let homepage: String?
    let id: Int?
    let imdbId: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompanyEntity]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}

struct GenreEntity: Decodable {
    let id: Int?
    let name: String?
}

struct ProductionCompanyEntity: Decodable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?
}
