//
//  UpcomingMoviesViewController+TV.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import UIKit

extension UpcomingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upcomingMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UpcomingMovieTableViewCell.cellIdentifier,
            for: indexPath
        ) as? UpcomingMovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = viewModel.upcomingMovies[indexPath.row]
        cell.configure(with: movie)
        cell.selectionStyle = .none
        cell.contentView.layer.borderColor = UIColor.orange.cgColor
        cell.contentView.layer.borderWidth = 2

        if indexPath.row == viewModel.upcomingMovies.count - 4 {
            viewModel.fetchUpcomingMovies()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = viewModel.upcomingMovies[indexPath.row].id else { return }
        coordinator?.navigateToMovieDetails(movieId: "\(movieId)")
    }
}
