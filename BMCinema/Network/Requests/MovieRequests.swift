//
//  MovieRequests.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

/// Requests for all Movie related APIs
enum MoviesRequests: RequestProtocol {
    case fetchNowPlayingMoviesFor(page: Int)
    case fetchPopularMoviesFor(page: Int)
    case fetchUpcomingMoviesFor(page: Int)
    case fetchMovieDetailsWith(id: String)

    var host: String {
        APIConstants.host
    }

    var path: String {
        switch self {
        case .fetchNowPlayingMoviesFor:
            return APIsPaths.nowPlayingPath
        case .fetchPopularMoviesFor:
            return APIsPaths.popularPath
        case .fetchUpcomingMoviesFor:
            return APIsPaths.upcomingPath
        case .fetchMovieDetailsWith(let id):
            return APIsPaths.moviePath + "/\(id)"
        }
    }

    var requestType: RequestType {
        .GET
    }

    var urlParams: [String: String?] {
        switch self {
        case .fetchNowPlayingMoviesFor(let page),
                .fetchPopularMoviesFor(let page),
                .fetchUpcomingMoviesFor(let page):
            return ["page": "\(page)"]
        case .fetchMovieDetailsWith:
            return [:]
        }
    }
}
