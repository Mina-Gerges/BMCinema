//
//  NowPlayingViewModel.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import UIKit
import Combine

enum NowPlayingMoviesViewModelState: Equatable {
    case loading
    case success
    case error(message: String)
}

class NowPlayingMoviesViewModel: ObservableObject {
    // MARK: - Properties
    @Published public private (set) var state: NowPlayingMoviesViewModelState = .loading
    @Published var nowPlayingMovies: [NowPlayingMovie] = []
    @Published var shownMoviesCount = 0
    @Published var totalMoviesCount = 0
    @Published var showErrorPlaceholder: Bool = false
    let fetchNowPlayingMoviesUseCase: FetchNowPlayingMoviesUseCase
    var currentPage = 1
    var canPaginate = true

    // MARK: - Initializer
    init(fetchNowPlayingMoviesUseCase: FetchNowPlayingMoviesUseCase) {
        self.fetchNowPlayingMoviesUseCase = fetchNowPlayingMoviesUseCase
    }

    // MARK: - Methods
    func fetchNowPlayingMovies() {
        guard canPaginate else { return }
        state = .loading
        Task {
            do {
                let paginatedModel = try await fetchNowPlayingMoviesUseCase.fetchNowPlayingMovies(page: currentPage)
                DispatchQueue.main.async { [weak self] in
                    self?.state = .success
                    if let movies = paginatedModel.movies {
                        self?.nowPlayingMovies.append(contentsOf: movies)
                    }
                    self?.currentPage += 1
                    self?.shownMoviesCount = self?.nowPlayingMovies.count ?? 0
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
}
