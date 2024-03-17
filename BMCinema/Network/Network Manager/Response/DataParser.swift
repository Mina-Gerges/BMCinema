//
//  DataParser.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation

public protocol DataParserProtocol {
  func parse<T: Decodable>(data: Data) throws -> T
}

public class DataParser: DataParserProtocol {
  private var jsonDecoder: JSONDecoder

  public init(jsonDecoder: JSONDecoder = JSONDecoder()) {
    self.jsonDecoder = jsonDecoder
    self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    dateFormatter.locale = Locale(identifier: "en-US")
    self.jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
  }

  public func parse<T: Decodable>(data: Data) throws -> T {
    do {
      return try jsonDecoder.decode(T.self, from: data)
    } catch {
      throw error
    }
  }
}
