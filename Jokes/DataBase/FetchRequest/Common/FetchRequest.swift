//
//  FetchRequest.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public protocol FetchRequest {
  associatedtype ModelType: DBModel
    
  var predicate: NSPredicate? { get }
  var sortDescriptors: [NSSortDescriptor]? { get }
}
