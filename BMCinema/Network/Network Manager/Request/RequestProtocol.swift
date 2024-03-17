//
//  RequestProtocol.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

public enum RequestContentType {
  case xFormWUrl
  case json
}

public protocol RequestProtocol {
  var host: String { get }
  var path: String { get }
  var requestType: RequestType { get }
  var headers: [String: String] { get }
  var params: [String: Any] { get }
  var urlParams: [String: String?] { get }
  var addAuthorizationToken: Bool { get }
  var requestContentType: RequestContentType { get }
}

// MARK: - Default RequestProtocol
extension RequestProtocol {
  var host: String {
    APIConstants.host
  }

  var addAuthorizationToken: Bool {
    true
  }

  var params: [String: Any] {
    [:]
  }

  var urlParams: [String: String?] {
    [:]
  }

  var headers: [String: String] {
    [:]
  }

  var requestContentType: RequestContentType {
    .json
  }

  func createURLRequest() throws -> URLRequest {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path

    if !urlParams.isEmpty {
      components.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
    }

    guard let url = components.url else { throw  NetworkError.invalidURL }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestType.rawValue

    if !headers.isEmpty {
      urlRequest.allHTTPHeaderFields = headers
    }

    if addAuthorizationToken {
      urlRequest.setValue(APIConstants.userAuth, forHTTPHeaderField: "Authorization")
    }

    if !params.isEmpty {
      var body: Data?
      if requestContentType == .json {
        body = try JSONSerialization.data(withJSONObject: params)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      } else {
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        var data = params.reduce("") { partialResult, element in
          return partialResult + "\(element.key)=\(element.value)&"
        }
        data.removeLast()
        body = data.data(using: .utf8)
      }
      urlRequest.httpBody = body
    }
    return urlRequest
  }
}
