//
//  APIConfig.swift
//  pick4you-api
//
//  Created by Roman Derevianko on 25.03.2020.
//  Copyright © 2020 Roman Derevianko. All rights reserved.
//

import Foundation

public protocol APIConfig {
  var useHttps: Bool { get }
  var httpHost: String { get }
  var httpPort: Int? { get }
}

public extension APIConfig {
  var httpPort: Int? { return nil }
}

public extension APIConfig {
  var baseUrl: String {
    var url = URLComponents()
    url.scheme = useHttps ? "https" : "http"
    url.host = httpHost
    url.port = httpPort
    return url.string!
  }
}


