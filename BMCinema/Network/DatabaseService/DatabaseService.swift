//
//  DatabaseService.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import Foundation
import SwiftData

class DatabaseService {
    // MARK: - Properties
    static var shared = DatabaseService()
    var container: ModelContainer?
    var context: ModelContext?

    // MARK: - Initializer
    init() {
        do {
            let schema = Schema([
                NowPlayingMovie.self,
            ])

            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - NowPlayingMovies Methods
    func save(nowPlayingMovie: NowPlayingMovie) {
        context?.insert(nowPlayingMovie)
    }

    func fetchNowPlayingMoviesPaginatedModel() async throws -> [NowPlayingMovie]{
        let descriptor = FetchDescriptor<NowPlayingMovie>()

        do {
            let fetchedMovies = try context?.fetch(descriptor) ?? []
            return fetchedMovies

        } catch {
            throw error
        }
    }
}
