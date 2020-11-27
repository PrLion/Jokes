//
//  NSEntityDescription+Helpers.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation
import CoreData

extension NSEntityDescription {
  var managedObjectClass: AnyClass? {
    return NSClassFromString(managedObjectClassName)
  }
}
