//
//  NetworkError.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

/// It's holding all different network related errors with their corresponding description
public enum NetworkError: LocalizedError {
  case network
  case invalidURL
  case invalidServerResponse
  public var errorDescription: String? {
    switch self {
    case .network:
      return "Please Check your internet connection."
    case .invalidURL:
      return "URL string is malformed."
    case .invalidServerResponse:
      return "Something went wrong. Please try again later."
    }
  }
}
