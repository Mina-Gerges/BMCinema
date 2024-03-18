//
//  PopularMoviesViewController.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import UIKit
import Combine

/// ViewController showing the list of popular movies in the Popular movies tab.
class PopularMoviesViewController: BaseViewController {
    // MARK: - IBoutlets
    @IBOutlet weak var moviesTV: UITableView?

    // MARK: - Properties
    var viewModel: PopularMoviesViewModel!
    var coordinator: PopularCoordinator?
    private var subscribers: [AnyCancellable] = []
    var emptyStateView = EmptyStateView()

    // MARK: - Initializer
    init(viewModel: PopularMoviesViewModel, coordinator: PopularCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupRefreshControl()
        bindViewToModel()
        fetchMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Methods
    func setupTableView() {
        moviesTV?.delegate = self
        moviesTV?.dataSource = self
        moviesTV?.register(
            UINib(nibName: PopularMovieTableViewCell.cellIdentifier, bundle: .main),
            forCellReuseIdentifier: PopularMovieTableViewCell.cellIdentifier
        )
        moviesTV?.accessibilityIdentifier = "moviesTV"
    }

    private func bindViewToModel() {
        viewModel?
            .$state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in self?.render(state: state) }
            .store(in: &subscribers)
    }

    func fetchMovies() {
        viewModel.fetchPopularMovies()
    }

    private func render(state: PopularMoviesViewModelState) {
        switch state {
        case .loading:
            showLoadingView()
        case .success:
            if viewModel.popularMovies.isEmpty {
                showEmptyStateView()
            } else {
                moviesTV?.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    self?.hideLoadingView()
                }
            }
        case .error(let message):
            showAlert(title: "Error", message: message)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                if self?.viewModel.popularMovies.isEmpty ?? false {
                    self?.showEmptyStateView()
                }
                self?.hideLoadingView()
            }
        }
    }
}
