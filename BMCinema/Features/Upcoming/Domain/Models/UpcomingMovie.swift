//
//  UpcomingMovie.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation

struct UpcomingMovie {
    let id: Int?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    
    /// Image Poster full path
    var posterImagePath: String? {
      AppConstants.imageBaseUrl + (posterPath ?? "")
    }
}
