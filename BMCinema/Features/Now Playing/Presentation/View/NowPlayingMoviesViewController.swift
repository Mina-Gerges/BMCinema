//
//  NowPlayingMoviesViewController.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import UIKit
import Combine

/// ViewController showing the list of now playing movies in the NowPlaying movies tab.
class NowPlayingMoviesViewController: BaseViewController {
    // MARK: - IBoutlets
    @IBOutlet weak var moviesCountStack: UIStackView?
    @IBOutlet weak var shownMoviesCountLabel: UILabel?
    @IBOutlet weak var shownMoviesLabel: UILabel?
    @IBOutlet weak var totalMoviesCountLabel: UILabel?
    @IBOutlet weak var totalMoviesLabel: UILabel?

    @IBOutlet weak var moviesTV: UITableView?

    // MARK: - Properties
    var viewModel: NowPlayingMoviesViewModel!
    var coordinator: NowPlayingCoordinator?
    private var subscribers: [AnyCancellable] = []
    var emptyStateView = EmptyStateView()

    // MARK: - Initializer
    init(viewModel: NowPlayingMoviesViewModel, coordinator: NowPlayingCoordinator) {
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
            UINib(nibName: NowPlayingMovieTableViewCell.cellIdentifier, bundle: .main),
            forCellReuseIdentifier: NowPlayingMovieTableViewCell.cellIdentifier
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
        shownMoviesLabel?.text = "Shown Movies"
        totalMoviesLabel?.text = "Total Movies"
        moviesCountStack?.isHidden = true
        viewModel.fetchNowPlayingMovies()
    }

    private func render(state: NowPlayingMoviesViewModelState) {
        switch state {
        case .loading:
            showLoadingView()
        case .success:
            if viewModel.nowPlayingMovies.isEmpty {
                showEmptyStateView()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    self?.hideLoadingView()
                }
            } else {
                shownMoviesCountLabel?.text = "\(viewModel.shownMoviesCount)"
                totalMoviesCountLabel?.text = "\(viewModel.totalMoviesCount)"
                moviesCountStack?.isHidden = false
                moviesTV?.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    self?.hideLoadingView()
                }
            }
        case .error(let message):
            showAlert(title: "Error", message: message)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                if self?.viewModel.nowPlayingMovies.isEmpty ?? false {
                    self?.showEmptyStateView()
                }
                self?.hideLoadingView()
            }
        }
    }
}
