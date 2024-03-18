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

        if indexPath.row == viewModel.popularMovies.count - 4 {
            viewModel.fetchPopularMovies()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
