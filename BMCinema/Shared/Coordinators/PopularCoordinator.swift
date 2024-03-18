//
//  PopularCoordinator.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import UIKit
import SwiftUI

/// The coordinator responsible for navigation through the Popular Tab.
class PopularCoordinator: NSObject, UINavigationControllerDelegate {
    // MARK: - Properties
    let navigationController = UINavigationController()

    // MARK: - Setup the first ViewController for this Coordinator
    func start() {
        navigationController.delegate = self

        let popularRepo = PopularMoviesRepo(requestManager: RequestManager())
        let fetchPopularMoviesUseCase = FetchPopularMoviesUseCase(repository: popularRepo)
        let popularMoviesViewModel = PopularMoviesViewModel(
            fetchPopularMoviesUseCase: fetchPopularMoviesUseCase
        )
        let popularViewController = PopularMoviesViewController(
            viewModel: popularMoviesViewModel,
            coordinator: self
        )
        navigationController.viewControllers = [popularViewController]
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
