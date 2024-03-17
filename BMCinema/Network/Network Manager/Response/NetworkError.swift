//
//  NetworkError.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

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
      return "The server returned an invalid response."
    }
  }
}
