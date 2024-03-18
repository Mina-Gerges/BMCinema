//
//  PopularMoviesPaginatedModel.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation
import SwiftData

struct PopularMoviesPaginatedModel {
    let dates: Dates?
    let page: Int?
    let movies: [PopularMovie]?
    let totalPages: Int?
    let totalResults: Int?
    
    init(dates: Dates?, page: Int?, movies: [PopularMovie]?, totalPages: Int?, totalResults: Int?) {
        self.dates = dates
        self.page = page
        self.movies = movies
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
