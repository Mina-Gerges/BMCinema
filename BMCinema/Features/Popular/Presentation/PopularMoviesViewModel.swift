//
//  PopularMoviesViewModel.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import UIKit
import Combine

enum PopularMoviesViewModelState: Equatable {
    case loading
    case success
    case error(message: String)
}

class PopularMoviesViewModel: ObservableObject {
    // MARK: - Properties
    @Published public private (set) var state: PopularMoviesViewModelState = .loading
    @Published var popularMovies: [PopularMovie] = []
    @Published var shownMoviesCount = 0
    @Published var totalMoviesCount = 0
    @Published var showErrorPlaceholder: Bool = false
    let fetchPopularMoviesUseCase: FetchPopularMoviesUseCase
    var currentPage = 1
    var canPaginate = true

    // MARK: - Initializer
    init(fetchPopularMoviesUseCase: FetchPopularMoviesUseCase) {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
    }

    // MARK: - Methods
    func fetchPopularMovies() {
        guard canPaginate else { return }
        state = .loading
        Task {
            do {
                let paginatedModel = try await fetchPopularMoviesUseCase.fetchPopularMovies(page: currentPage)
                DispatchQueue.main.async { [weak self] in
                    self?.state = .success
                    if let movies = paginatedModel.movies {
                        self?.popularMovies.append(contentsOf: movies)
                    }
                    self?.currentPage += 1
                    self?.canPaginate = paginatedModel.page ?? 0 < paginatedModel.totalPages ?? 0
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.state = .error(message: error.localizedDescription)
                }
            }
        }
    }
}
