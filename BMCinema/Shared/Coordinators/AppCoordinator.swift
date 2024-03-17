//
//  AppCoordinator.swift
//  BMCinema
//
//  Created by Mina Hanna on 16/03/2024.
//

import UIKit

class AppCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let tabBarController = UITabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
