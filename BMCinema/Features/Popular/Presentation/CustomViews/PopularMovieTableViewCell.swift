//
//  PopularMovieTableViewCell.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import UIKit

class PopularMovieTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverViewLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!

    // MARK: - Properties
    static let cellIdentifier = "\(PopularMovieTableViewCell.self)"
    private let placeholderImage = UIImage(resource: .imagePlaceholder)
    private var imageLoadingTask: URLSessionDataTask?

    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        imageLoadingTask?.cancel()
    }

    func configure(with movie: PopularMovie) {
        movieTitleLabel.text = movie.title
        movieOverViewLabel.text = movie.overview
        popularityLabel.text = "\(movie.popularity ?? 0)"
        voteAverageLabel.text = "\(movie.voteAverage ?? 0)"

        // Load image asynchronously
        if let posterImagePath = movie.posterImagePath {
            if let cachedImage = SharedImageCache.sharedInstance.object(forKey: posterImagePath as NSString) {
                // If the image is already cached, use it
                movieImageView.image = cachedImage
            } else {
                movieImageView.image = placeholderImage
                guard let imageUrl = URL(string: posterImagePath) else { return }
                let imageLoadingRequest = URLRequest(url: imageUrl)

                imageLoadingTask = URLSession.shared.dataTask(with: imageLoadingRequest) { [weak self] (data, response, error) in
                    guard let self = self else { return }

                    DispatchQueue.main.async { [weak self] in
                        if let data = data, let image = UIImage(data: data) {
                            // Cache the loaded image
                            SharedImageCache.sharedInstance.setObject(image, forKey: posterImagePath as NSString)

                            // Check if the cell is still displaying the same movie
                            if self?.movieTitleLabel.text == movie.title {
                                self?.movieImageView.image = image
                            }
                        }
                    }
                }

                imageLoadingTask?.resume()
            }
        }
    }
}
