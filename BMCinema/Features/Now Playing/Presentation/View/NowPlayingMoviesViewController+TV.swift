//
//  NowPlayingMoviesViewController+TV.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import UIKit

extension NowPlayingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.nowPlayingMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NowPlayingMovieTableViewCell.cellIdentifier,
            for: indexPath
        ) as? NowPlayingMovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = viewModel.nowPlayingMovies[indexPath.row]
        cell.configure(with: movie)
        cell.selectionStyle = .none
        
        if indexPath.row == viewModel.nowPlayingMovies.count - 4 {
            viewModel.fetchNowPlayingMovies()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = viewModel.nowPlayingMovies[indexPath.row].id else { return }
        coordinator?.navigateToMovieDetails(movieId: "\(movieId)")
    }
}
