//
//  PopularCoordinator.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import UIKit

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
}
