//
//  PopularMoviesViewController+TV.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import UIKit

extension PopularMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.popularMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PopularMovieTableViewCell.cellIdentifier,
            for: indexPath
        ) as? PopularMovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = viewModel.popularMovies[indexPath.row]
        cell.configure(with: movie)
        cell.selectionStyle = .none

        if indexPath.row == viewModel.popularMovies.count - 4 {
            viewModel.fetchPopularMovies()
        }

        cell.accessibilityIdentifier = "PopularMovieCell_\(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = viewModel.popularMovies[indexPath.row].id else { return }
        coordinator?.navigateToMovieDetails(movieId: "\(movieId)")
    }
}
