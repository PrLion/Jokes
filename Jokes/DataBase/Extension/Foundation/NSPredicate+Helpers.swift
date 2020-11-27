//
//  NSPredicate+Helpers.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

extension NSPredicate {
  convenience init(idKey key: String = "id", ids: [UUID]) {
    self.init(format: "%K IN %@", key, ids)
  }
}
