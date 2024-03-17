//
//  UpcomingMoviesPaginatedModel.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation

struct UpcomingMoviesPaginatedModel {
  let dates: Dates?
  let page: Int?
  let movies: [UpcomingMovie]?
  let totalPages: Int?
  let totalResults: Int?
}
