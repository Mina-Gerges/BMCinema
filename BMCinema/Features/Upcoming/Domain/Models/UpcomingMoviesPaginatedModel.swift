//
//  UpcomingMoviesPaginatedModel.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation
import SwiftData

struct UpcomingMoviesPaginatedModel {
    let dates: Dates?
    let page: Int?
    let movies: [UpcomingMovie]?
    let totalPages: Int?
    let totalResults: Int?

    init(dates: Dates?, page: Int?, movies: [UpcomingMovie]?, totalPages: Int?, totalResults: Int?) {
        self.dates = dates
        self.page = page
        self.movies = movies
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
