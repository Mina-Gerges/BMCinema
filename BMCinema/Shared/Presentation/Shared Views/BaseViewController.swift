//
//  BaseViewController.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import UIKit

/// Base ViewController with common functionality to be conformed and used in all viewControllers
class BaseViewController: UIViewController {
    // MARK: - Loading View
    var loadingView: UIView?

    func showLoadingView() {
        guard loadingView == nil else { return }

        let loadingView = UIView(frame: UIScreen.main.bounds)
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.center = loadingView.center
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)

        view.addSubview(loadingView)
        self.loadingView = loadingView
    }

    func hideLoadingView() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }

    // MARK: - Show Alert
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
