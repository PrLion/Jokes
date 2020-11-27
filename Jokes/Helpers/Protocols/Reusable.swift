//
//  Reusable.swift
//  Jokes
//
//  Created by mac on 10.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public protocol Reusable {
  static var reuseIdentifier: String { get }
}

public extension Reusable where Self: NSObject {
  static var reuseIdentifier: String {
    return try! String(describing: self).substringMatches(regex: "[[:word:]]+").first!
  }
}
