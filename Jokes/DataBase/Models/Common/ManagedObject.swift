//
//  ManagedObject.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation
import CoreData

open class ManagedObject: NSManagedObject {
  open class var uniquenessConstraints: [[Any]] {
    return [["id"]]
  }
}
