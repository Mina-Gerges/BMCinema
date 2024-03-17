//
//  SharedImageCache.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import UIKit

/// Class responsible for caching poster images of movies lists
class SharedImageCache: NSCache<NSString, UIImage> {
    static let sharedInstance = SharedImageCache()

    override init() {
        super.init()

        NotificationCenter.default.addObserver(self, selector: #selector(emptyCache), name: UIApplication.didReceiveMemoryWarningNotification, object: UIApplication.shared)
    }

    @objc private func emptyCache() {
        removeAllObjects()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
