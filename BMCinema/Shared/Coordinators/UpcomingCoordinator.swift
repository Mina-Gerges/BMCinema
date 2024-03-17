//
//  UpcomingCoordinator.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import UIKit

/// The coordinator responsible for navigation through the Upcoming Tab.
class UpcomingCoordinator: NSObject, UINavigationControllerDelegate {
    // MARK: - Properties
    let navigationController = UINavigationController()

    // MARK: - Setup the first ViewController for this Coordinator
    func start() {
        navigationController.delegate = self

    }
}
