//
//  APIModule.swift
//  pick4you-api
//
//  Created by Roman Derevianko on 25.03.2020.
//  Copyright © 2020 Roman Derevianko. All rights reserved.
//

import Foundation

public typealias ConfigType = APIConfig
public private(set) var config: ConfigType!

public func configure(with configType: ConfigType) {
    config = configType
}

public func httpProvider<R: HTTPRequest>() -> HTTPProvider<R> {
  return HTTPProvider<R>()
}
