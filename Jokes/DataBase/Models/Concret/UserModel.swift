//
//  UserModel.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public protocol UserModel: AnyModel {
    var firstname: String? { get }
    var lastname: String? { get }
}
