//
//  DBModule.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation
import CoreData
import DataRaft

public func dbService<M: DBModel>(db: DataRaft = .default) -> DBService<M> {
  return DBService(db: db)
}
