//
//  JokeCRUDModel.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public struct JokeCRUDModel: CRUDModel, JokeDBModel, Codable {
    public typealias DBModel = Joke
    
    public var id: Int32
    public var joke: String?
    public var isLike: Bool? = false
    public var isMy: Bool? = false
    
    public init(with model: DBModel) {
        id = model.id
        joke = model.joke
        isLike = model.isLike
        isMy = model.isMy
    }
}
