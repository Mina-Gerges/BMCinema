//
//  MovieDetailsView.swift
//  BMCinema
//
//  Created by Mina Hanna on 18/03/2024.
//

import SwiftUI

import SwiftUI

struct MovieDetailsView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: MovieDetailsViewModel

    // MARK: - Body
    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            case .success:
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .top) {
                        AsyncImage(url: URL(string: viewModel.movie?.posterImagePath ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(0.67, contentMode: .fit)
                                .frame(height: 150)
                        } placeholder: {
                            Image(.imagePlaceholder)
                                .resizable()
                                .aspectRatio(0.67, contentMode: .fit)
                                .frame(height: 150)
                                .opacity(0.5)
                                .overlay(
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                )
                        }
                        VStack(alignment: .leading) {
                            Text(viewModel.movie?.title ?? "")
                                .font(.title)
                            Text(viewModel.movie?.releaseDate ?? "")
                                .font(.subheadline)

                            Spacer()
                            HStack {
                                Image(systemName: "star.fill")
                                Text(viewModel.movie?.voteAverage?.formattedString(decimalPoints: 1) ?? "")
                            }
                            .foregroundColor(.red)
                            .padding(.bottom, 10)

                            HStack {
                                Image(systemName: "arrow.up.right.circle.fill")
                                Text(viewModel.movie?.popularity?.formattedString(decimalPoints: 3) ?? "")
                            }
                            .foregroundColor(.yellow)
                        }
                    }

                    if let genres = viewModel.movie?.genres {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(genres, id: \.id) { genre in
                                    Text(genre.name ?? "")
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                                        .background(Color.blue)
                                        .cornerRadius(20)
                                }
                            }
                        }
                    }

                    Text(viewModel.movie?.overview ?? "")
                        .font(.body)
                }
                .padding()
                .navigationTitle(viewModel.movie?.title ?? "")
            case .error(let message):
                EmptyStateSwiftUIView(message: message, refreshButtonAction: viewModel.fetchMovieDetails)
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchMovieDetails()
        }
    }
}


#Preview {
    MovieDetailsView(
        viewModel: MovieDetailsViewModel(
            movieId: "",
            fetchMovieDetailsUseCase: FetchMovieDetailsUseCase(
                repository: MovieDetailsRepo(requestManager: RequestManager())
            )
        )
    )
}
