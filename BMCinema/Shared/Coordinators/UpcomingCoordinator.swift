//
//  UpcomingCoordinator.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import UIKit
import SwiftUI

/// The coordinator responsible for navigation through the Upcoming Tab.
class UpcomingCoordinator: NSObject, UINavigationControllerDelegate {
    // MARK: - Properties
    let navigationController = UINavigationController()

    // MARK: - Setup the first ViewController for this Coordinator
    func start() {
        navigationController.delegate = self

        let movieRepo = UpcomingMoviesRepo(requestManager: RequestManager())
        let fetchUpcomingMoviesUseCase = FetchUpcomingMoviesUseCase(repository: movieRepo)
        let upcomingViewModel = UpcomingMoviesViewModel(
            fetchUpcomingMoviesUseCase: fetchUpcomingMoviesUseCase
        )
        let upcomingViewController = UpcomingMoviesViewController(
            viewModel: upcomingViewModel,
            coordinator: self
        )
        navigationController.viewControllers = [upcomingViewController]
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
