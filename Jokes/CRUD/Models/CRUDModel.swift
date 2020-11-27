//
//  CRUDModel.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public protocol CRUDModel: AnyModel {
    associatedtype DBModels: DBModel
  init(with model: DBModels)
}
