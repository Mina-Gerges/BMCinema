//
//  MockUpcomingMovieDataProvider.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation
@testable import BMCinema

/// Mock Successful fetching
class MockUpcomingMovieRepoSuccess: UpcomingMoviesRepoProtocol {
    func fetchMovies(page: Int) async throws -> BMCinema.MoviesPaginatedEntity {
        guard let mockData = loadMockData() else {
            throw NSError(domain: "MockDataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load mock data"])
        }
        return mockData
    }

    func loadMockData() -> MoviesPaginatedEntity? {
        let testBundle = Bundle(for: type(of: self))
         guard let path = testBundle.path(forResource: "UpcomingPaginatedMockData", ofType: "json") else {
             print("Failed to locate mock_data.json")
             return nil
         }

         do {
             let url = URL(fileURLWithPath: path)
             let data = try Data(contentsOf: url)
             let decoder = JSONDecoder()
             decoder.keyDecodingStrategy = .convertFromSnakeCase
             let mockData = try decoder.decode(MoviesPaginatedEntity.self, from: data)
             return mockData
         } catch {
             print("Error decoding mock data: \(error)")
             return nil
         }
     }
}
