//
//  UserFetch.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public enum UserFetch {
  case all
}

extension UserFetch: FetchRequest {
  public typealias ModelType = User
  
  public var predicate: NSPredicate? { return nil }
  public var sortDescriptors: [NSSortDescriptor]? { return nil }
}
