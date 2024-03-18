//
//  RequestManager.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

public protocol RequestManagerProtocol {
  func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

/// The manager responsible for preparing the URL Session, performing the requests and parsing the data.
public class RequestManager: RequestManagerProtocol {
  let apiManager: APIManagerProtocol
  let parser: DataParserProtocol

  public init() {
    self.parser = DataParser()
    self.apiManager = APIManager(urlSession: RequestManager.getUrlSession(), parser: parser)
  }

  private static func getUrlSession() -> URLSession {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 90
    configuration.timeoutIntervalForResource = 90
    configuration.requestCachePolicy = .useProtocolCachePolicy
    return URLSession(configuration: configuration)
  }

  public func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
    let data = try await apiManager.perform(request)
    let decoded: T = try parser.parse(data: data)
    return decoded
  }
}
