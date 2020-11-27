//
//  HTTPRequest.swift
//  pick4you-api
//
//  Created by Roman Derevianko on 24.03.2020.
//  Copyright © 2020 Roman Derevianko. All rights reserved.
//

import Foundation
import Alamofire

public protocol HTTPRequest: Request {
  associatedtype PathType: PathComponent
  associatedtype APIMethod
  var apiMethod: APIMethod { get }
  var pathComponents: [PathType] { get }
  
  init(apiMethod: APIMethod, baseURL: String)
}

extension HTTPRequest {
  public var path: String {
    return pathComponents.path()
  }
}



