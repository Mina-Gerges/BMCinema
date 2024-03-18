//
//  NowPlayingCoordinator.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import UIKit

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
}
