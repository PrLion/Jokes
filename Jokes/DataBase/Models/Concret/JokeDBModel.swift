//
//  JokeDBModel.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public protocol JokeDBModel: AnyModel {
    var joke: String? { get }
    var isLike: Bool? { get }
    var isMy: Bool? { get }
}
