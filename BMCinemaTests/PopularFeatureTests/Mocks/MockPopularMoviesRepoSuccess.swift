//
//  MockPopularMoviesRepoSuccess.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 18/03/2024.
//

import Foundation
@testable import BMCinema

/// Mock Successful fetching
class MockPopularMovieRepoSuccess: PopularMoviesRepoProtocol {
    func fetchMovies(page: Int) async throws -> BMCinema.MoviesPaginatedEntity {
        guard let mockData = try loadMockData() else {
            throw NSError(domain: "MockDataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load popular mock data"])
        }
        return mockData
    }

    func loadMockData() throws -> MoviesPaginatedEntity? {
        let testBundle = Bundle(for: type(of: self))
         guard let path = testBundle.path(forResource: "PopularPaginatedMockData", ofType: "json") else {
             throw NSError(domain: "MockDataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to locate PopularPaginatedMockData.json"])
         }

         do {
             let url = URL(fileURLWithPath: path)
             let data = try Data(contentsOf: url)
             let decoder = JSONDecoder()
             decoder.keyDecodingStrategy = .convertFromSnakeCase
             let mockData = try decoder.decode(MoviesPaginatedEntity.self, from: data)
             return mockData
         } catch {
             throw NSError(domain: "MockDataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error decoding popular mock data: \(error)"])
         }
     }
}
