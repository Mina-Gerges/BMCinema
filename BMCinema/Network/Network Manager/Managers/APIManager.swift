//
//  APIManager.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

public protocol APIManagerProtocol {
  var parser: DataParserProtocol { get set }
  func perform(_ request: RequestProtocol) async throws -> Data
}

/// The manager responsible for performomg the actual calling and handling error messages.
public class APIManager: NSObject, APIManagerProtocol {
  private let urlSession: URLSession
  public var parser: DataParserProtocol

  public init(urlSession: URLSession = URLSession.shared, parser: DataParserProtocol) {
    self.urlSession = urlSession
    self.parser = parser
  }

  public func perform(_ request: RequestProtocol) async throws -> Data {
      if NetworkReachability.isConnected {
        urlSession.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
      } else {
        urlSession.configuration.requestCachePolicy = .returnCacheDataElseLoad
      }
    let (data, response) = try await urlSession.data(for: request.createURLRequest())
    guard let httpResponse = response as? HTTPURLResponse,
    httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
    return data
  }
}
