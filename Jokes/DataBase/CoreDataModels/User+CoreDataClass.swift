//
//  User+CoreDataClass.swift
//  
//
//  Created by mac on 11.09.2020.
//
//

import Foundation
import CoreData

@objc(User)
public class User: ManagedObject, DBModel, UserModel  {
    public typealias CRUDType = UserModel
    public typealias FetchType = UserFetch
    
    // MARK: - Map methods
    
    public func map(with model: UserModel) throws {
        id = model.id
        firstname = model.firstname
        lastname = model.lastname
    }
}
