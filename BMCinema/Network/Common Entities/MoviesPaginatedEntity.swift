//
//  MoviesPaginatedEntity.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

struct MoviesPaginatedEntity: Decodable {
  let dates: Dates?
  let page: Int?
  let results: [MovieEntity]?
  let totalPages: Int?
  let totalResults: Int?
}

struct Dates: Decodable {
  let maximum: String?
  let minimum: String?
}
