//
//  NowPlayingCoordinator.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import UIKit
import SwiftUI

/// The coordinator responsible for navigation through the Now Playing Tab..
class NowPlayingCoordinator: NSObject, UINavigationControllerDelegate {
    // MARK: - Properties
    let navigationController = UINavigationController()

    // MARK: - Setup the first ViewController for this Coordinator
    func start() {
        navigationController.delegate = self

        let nowPlayingRepo = NowPlayingMoviesRepo(requestManager: RequestManager())
        let fetchNowPlayingMoviesUseCase = FetchNowPlayingMoviesUseCase(repository: nowPlayingRepo)
        let nowPlayingMoviesViewModel = NowPlayingMoviesViewModel(
            fetchNowPlayingMoviesUseCase: fetchNowPlayingMoviesUseCase
        )
        let nowPlayingViewController = NowPlayingMoviesViewController(
            viewModel: nowPlayingMoviesViewModel,
            coordinator: self
        )
        navigationController.viewControllers = [nowPlayingViewController]
    }

    func navigateToMovieDetails(movieId: String) {
        let movieDetailsRepo = MovieDetailsRepo(requestManager: RequestManager())
        let fetchMovieDetailsUseCase = FetchMovieDetailsUseCase(repository: movieDetailsRepo)
        let movieDetailsViewModel = MovieDetailsViewModel(movieId: movieId, fetchMovieDetailsUseCase: fetchMovieDetailsUseCase)

        let movieDetailsView = MovieDetailsView(viewModel: movieDetailsViewModel)
        let hostingController = UIHostingController(rootView: movieDetailsView)

        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(hostingController, animated: true)
    }
}
