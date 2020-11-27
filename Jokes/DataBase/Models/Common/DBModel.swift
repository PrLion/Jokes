//
//  DBModel.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation
import CoreData

public protocol DBModel: AnyModel where Self: NSManagedObject {
  associatedtype CRUDType
  associatedtype FetchType: FetchRequest
  func map(with model: CRUDType) throws
}
