//
//  AppCoordinator.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import UIKit

/// The main coordinator responsible for navigation through the whole application.
class AppCoordinator {
    // MARK: - Properties
    private let window: UIWindow

    // MARK: - Initializer
    init(window: UIWindow) {
        self.window = window

        let tabBarController =  UITabBarController()
        tabBarController.viewControllers = [
//            setupNowPlayingCoordinator(),
//            setupPopularCoordinator(),
            setupUpcomingCoordinator()
        ]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    // MARK: - Setup Coordinators

    private func setupNowPlayingCoordinator() -> UIViewController {
        let nowPlayingCoordinator = NowPlayingCoordinator()
        nowPlayingCoordinator.start()
        nowPlayingCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Now Playing", image: UIImage(systemName: "film"), tag: 0)
        return nowPlayingCoordinator.navigationController
    }

    private func setupPopularCoordinator() -> UIViewController {
        let popularCoordinator = PopularCoordinator()
        popularCoordinator.start()
        popularCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Popular", image: UIImage(systemName: "star.fill"), tag: 1)
        return popularCoordinator.navigationController
    }

    private func setupUpcomingCoordinator() -> UIViewController {
        let upcomingCoordinator = UpcomingCoordinator()
        upcomingCoordinator.start()
        upcomingCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Upcoming", image: UIImage(systemName: "calendar"), tag: 2)
        return upcomingCoordinator.navigationController
    }
}
