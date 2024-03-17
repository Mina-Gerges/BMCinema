//
//  UpcomingMoviesViewModel.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import UIKit
import Combine

enum UpcomingMoviesViewModelState: Equatable {
    case loading
    case success
    case error(message: String)
}

class UpcomingMoviesViewModel: ObservableObject {
    // MARK: - Properties
    @Published public private (set) var state: UpcomingMoviesViewModelState = .loading
    @Published var upcomingMovies: [UpcomingMovie] = []
    @Published var shownMoviesCount = 0
    @Published var totalMoviesCount = 0
    @Published var showErrorPlaceholder: Bool = false
    let fetchUpcomingMoviesUseCase: FetchUpcomingMoviesUseCase
//    weak var detailsCoordinator: DetailsCoordinator?
    private var currentPage = 1
    private var canPaginate = true

    // MARK: - Initializer
    init(fetchUpcomingMoviesUseCase: FetchUpcomingMoviesUseCase) {
        self.fetchUpcomingMoviesUseCase = fetchUpcomingMoviesUseCase
//        self.detailsCoordinator = detailsCoordinator
    }

    // MARK: - Methods
    func fetchUpcomingMovies() {
        guard canPaginate else { return }
        state = .loading
        Task {
            do {
                let paginatedModel = try await fetchUpcomingMoviesUseCase.fetchUpcomingMovies(page: currentPage)
                DispatchQueue.main.async { [weak self] in
                    self?.state = .success
                    if let movies = paginatedModel.movies {
                        self?.upcomingMovies.append(contentsOf: movies)
                    }
                    self?.currentPage += 1
                    self?.shownMoviesCount = self?.upcomingMovies.count ?? 0
                    self?.totalMoviesCount = paginatedModel.totalResults ?? 0
                    self?.canPaginate = paginatedModel.page ?? 0 < paginatedModel.totalPages ?? 0
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.state = .error(message: error.localizedDescription)
                }
            }
        }
    }

    // MARK: - Navigation
    func showMovieDetails(withRow row: Int) {
        guard let movieId = upcomingMovies[row].id else { return }
//        detailsCoordinator?.showMovieDetails(withId: "\(movieId)")
    }
}
