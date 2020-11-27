//
//  PathComponent.swift
//  pick4you-api
//
//  Created by Roman Derevianko on 24.03.2020.
//  Copyright © 2020 Roman Derevianko. All rights reserved.
//

import Foundation

public protocol PathComponent: CustomStringConvertible {
  
  var rawValue: CustomStringConvertible { get }
  
  init(_ rawValue: CustomStringConvertible)
}

public extension PathComponent {
  var description: String { return rawValue.description }
}

extension Array where Element: PathComponent {
  func path() -> String {
    return "/".appending(map { $0.description }.joined(separator: "/"))
  }
}
