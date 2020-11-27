//
//  Config.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

struct Config {
  static let shared = Config()
}

extension Config: APIConfig {
  var useHttps: Bool { return true }
  var httpHost: String { return "api.icndb.com" }
}
