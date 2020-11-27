//
//  UserCRUDModel.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public struct UserCRUDModel: CRUDModel, UserModel {
    public typealias DBModel = User
    
    public var id: Int32
    public var firstname: String?
    public var lastname: String?
    
    public init(with model: DBModel) {
        id = model.id
        firstname = model.firstname
        lastname = model.lastname
    }
}
