//
//  MovieDetailsViewModel.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import Foundation

enum MovieDetailsViewModelState: Equatable {
    case loading
    case success
    case error(message: String)
}

class MovieDetailsViewModel: ObservableObject {
    // MARK: - Properties
    @Published public private (set) var state: MovieDetailsViewModelState = .loading
    @Published var movie: MovieDetailsModel?
    let movieId: String?
    let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase

    // MARK: - Initializer
    init(movieId: String, fetchMovieDetailsUseCase: FetchMovieDetailsUseCase) {
        self.movieId = movieId
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
    }

    // MARK: - Methods
    func fetchMovieDetails() {
        state = .loading
        Task {
            do {
                let movieDetailsModel = try await fetchMovieDetailsUseCase.fetchMovieDetails(withId: movieId ?? "")
                DispatchQueue.main.async { [weak self] in
                    self?.movie = movieDetailsModel
                    self?.state = .success
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.state = .error(message: error.localizedDescription)
                }
            }
        }
    }
}
