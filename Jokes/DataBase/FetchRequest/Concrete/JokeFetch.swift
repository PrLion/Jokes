//
//  JokeFetch.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public enum JokeFetch {
  case all
    case isLike
  case by(id: Int32)
}

extension JokeFetch: FetchRequest {
  public typealias ModelType = Joke
  
  public var predicate: NSPredicate? {
    switch self {
    case .all: return NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ModelType.isMyJoke), false])
    case .isLike: return NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ModelType.isLikeJoke), true])
    case .by(let id): return NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ModelType.id), id])
    }
  }
  
  public var sortDescriptors: [NSSortDescriptor]? {
    return nil
  }
}
