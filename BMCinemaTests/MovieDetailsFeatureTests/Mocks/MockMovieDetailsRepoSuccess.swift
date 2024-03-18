//
//  MockMovieDetailsRepoSuccess.swift
//  BMCinemaTests
//
//  Created by Mina Hanna on 18/03/2024.
//

import Foundation
@testable import BMCinema

/// Mock Movie Details Successful fetching
class MockMovieDetailsRepoSuccess: MoviesDetailsRepoProtocol {
    func fetchMovie(withId id: String) async throws -> BMCinema.MovieEntity {
        guard let mockData = try loadMockData() else {
            throw NSError(domain: "MockDataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load Movie Details mock data"])
        }
        return mockData
    }

    func loadMockData() throws -> MovieEntity? {
        let testBundle = Bundle(for: type(of: self))
         guard let path = testBundle.path(forResource: "MovieDetailsMockData", ofType: "json") else {
             throw NSError(domain: "MockDataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to locate MovieDetailsMockData.json"])
         }

         do {
             let url = URL(fileURLWithPath: path)
             let data = try Data(contentsOf: url)
             let decoder = JSONDecoder()
             decoder.keyDecodingStrategy = .convertFromSnakeCase
             let mockData = try decoder.decode(MovieEntity.self, from: data)
             return mockData
         } catch {
             throw NSError(domain: "MockDataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error decoding movie details mock data: \(error)"])
         }
     }
}
