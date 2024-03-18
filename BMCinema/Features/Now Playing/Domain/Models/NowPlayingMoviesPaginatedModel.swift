//
//  NowPlayingMoviesPaginatedModel.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation

struct NowPlayingMoviesPaginatedModel {
  let dates: Dates?
  let page: Int?
  let movies: [NowPlayingMovie]?
  let totalPages: Int?
  let totalResults: Int?
}
