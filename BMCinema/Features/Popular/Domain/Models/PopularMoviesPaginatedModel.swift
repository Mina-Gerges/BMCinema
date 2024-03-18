//
//  PopularMoviesPaginatedModel.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation

struct PopularMoviesPaginatedModel {
  let dates: Dates?
  let page: Int?
  let movies: [PopularMovie]?
  let totalPages: Int?
  let totalResults: Int?
}
