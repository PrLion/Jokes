//
//  CRUDModule.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public func crudService<M: CRUDModel>(dbService: DBService<M.DBModels> = dbService()) -> CRUDService<M> {
  return CRUDService(dbService: dbService)
}
