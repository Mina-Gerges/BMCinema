//
//  EmptyStateView.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import UIKit

/// The view shown when no movies fetched in any movies list viewController. 
class EmptyStateView: UIView {
    // MARK: - Properties
    var refreshButtonAction: (() -> Void)?

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "No movies available"
        label.textAlignment = .center
        return label
    }()

    private lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh", for: .normal)
        button.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Methods
    private func setupUI() {
        addSubview(messageLabel)
        addSubview(refreshButton)

        // Configure layout constraints
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20)
        ])

        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20)
        ])
    }

    @objc private func refreshButtonTapped() {
        refreshButtonAction?()
    }
}
