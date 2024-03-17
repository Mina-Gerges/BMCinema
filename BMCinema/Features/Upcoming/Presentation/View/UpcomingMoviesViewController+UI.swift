//
//  UpcomingMoviesViewController+UI.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import UIKit

extension UpcomingMoviesViewController {
    // MARK: - Empty State View
    func showEmptyStateView() {
        moviesTV?.isHidden = true
        emptyStateView.frame = view.bounds
        emptyStateView.refreshButtonAction = { [weak self] in
            self?.viewModel.fetchUpcomingMovies()
        }
        view.addSubview(emptyStateView)
    }

    func hideEmptyStateView() {
        moviesTV?.isHidden = false
        emptyStateView.removeFromSuperview()
    }

    // MARK: - Refresh Control
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        moviesTV?.refreshControl = refreshControl
    }

    @objc func refreshTableView(_ sender: UIRefreshControl) {
        fetchMovies()
        sender.endRefreshing()
    }
}
