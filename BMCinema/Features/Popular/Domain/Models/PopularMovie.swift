//
//  PopularMovie.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation

struct PopularMovie {
    let id: Int?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let title: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    /// Image Poster full path
    var posterImagePath: String? {
        AppConstants.imageBaseUrl + (posterPath ?? "")
    }
    
    init(id: Int?, overview: String?, popularity: Double?, posterPath: String?, title: String?, voteAverage: Double?, voteCount: Int?) {
        self.id = id
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
