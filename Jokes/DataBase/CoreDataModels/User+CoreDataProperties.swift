//
//  User+CoreDataProperties.swift
//  
//
//  Created by mac on 11.09.2020.
//
//

import Foundation
import CoreData

extension User {
    @NSManaged public var id: Int32
    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
}
