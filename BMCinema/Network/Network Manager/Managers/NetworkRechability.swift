//
//  NetworkRechability.swift
//  BMCinema
//
//  Created by Mina Hanna on 17/03/2024.
//

import Foundation
import Network

/// It's responsible for checking Network reachability and detect if the app is online or offline.
public enum NetworkReachability {
  public static let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
  public static let monitor = NWPathMonitor()

  public static private(set) var isConnected = false
  public static private(set) var isExpensive = false
  public static private(set) var currentConnectionType: NWInterface.InterfaceType?

  public static func startMonitoring() {
    NetworkReachability.monitor.pathUpdateHandler = { path in
      NetworkReachability.isConnected = path.status != .unsatisfied
      NetworkReachability.isExpensive = path.isExpensive
      NetworkReachability.currentConnectionType =
      NWInterface.InterfaceType.allCases.first { path.usesInterfaceType($0) }
    }
    NetworkReachability.monitor.start(queue: NetworkReachability.queue)
  }

  public static func stopMonitoring() {
    NetworkReachability.monitor.cancel()
  }
}

public extension Notification.Name {
  static let connectivityStatus = Notification.Name(rawValue: "connectivityStatusChanged")
}

extension NWInterface.InterfaceType: CaseIterable {
  public static var allCases: [NWInterface.InterfaceType] = [
    .other,
    .wifi,
    .cellular,
    .loopback,
    .wiredEthernet
  ]
}
