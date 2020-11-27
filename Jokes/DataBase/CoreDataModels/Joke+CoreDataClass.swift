//
//  Joke+CoreDataClass.swift
//  
//
//  Created by mac on 11.09.2020.
//
//

import Foundation
import CoreData

@objc(Joke)
public class Joke: ManagedObject, DBModel , JokeDBModel  {
    public typealias CRUDType = JokeDBModel
    public typealias FetchType = JokeFetch
    
    // MARK: - Map methods
    
    public var isMy: Bool? {
        get { return isMyJoke }
        set { isMyJoke = newValue ?? false }
    }
    
    public var isLike: Bool? {
        get { return isLikeJoke }
        set { isLikeJoke = newValue ?? false }
    }
    
    public func map(with model: JokeDBModel) throws {
        id = model.id
        joke = model.joke
        isLike = model.isLike ?? false
        isMy = model.isMy ?? false
    }
}
