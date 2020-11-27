//
//  Joke+CoreDataProperties.swift
//  
//
//  Created by mac on 11.09.2020.
//
//

import Foundation
import CoreData


extension Joke {
    @NSManaged public var id: Int32
    @NSManaged public var joke: String?
    @NSManaged public var isLikeJoke: Bool
    @NSManaged public var isMyJoke: Bool
}
