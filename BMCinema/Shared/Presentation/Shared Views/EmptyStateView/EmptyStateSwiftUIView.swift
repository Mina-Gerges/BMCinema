//
//  EmptyStateSwiftUIView.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import SwiftUI

/// The view shown when no movie details fetched in the movie details.
struct EmptyStateSwiftUIView: View {
    // MARK: - Properties
    let message: String
    var refreshButtonAction: (() -> Void)?

    var body: some View {
        VStack {
            Text(message)
                .font(.headline)
                .padding()

            Button("Refresh", action: {
                refreshButtonAction?()
            })
            .padding()
        }
    }
}
