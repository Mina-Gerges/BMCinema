//
//  NowPlayingMovie.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation
import SwiftData

@Model
class NowPlayingMovie: Identifiable, Hashable {
    @Attribute(.unique) var id: Int?
    let overview: String?
    let posterPath: String?
    let title: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    /// Image Poster full path
    var posterImagePath: String? {
        AppConstants.imageBaseUrl + (posterPath ?? "")
    }
    
    init(id: Int?, overview: String?, posterPath: String?, title: String?, voteAverage: Double?, voteCount: Int?) {
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
