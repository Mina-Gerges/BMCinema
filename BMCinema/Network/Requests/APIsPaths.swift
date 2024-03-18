//
//  APIsPaths.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

/// Paths for Network API Calls
enum APIsPaths {
    static let moviePath = "/3/movie"
    static let nowPlayingPath = moviePath + "/now_playing"
    static let popularPath = moviePath + "/popular"
    static let upcomingPath = moviePath + "/upcoming"
}
