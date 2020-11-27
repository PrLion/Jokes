//
//  Request.swift
//  pick4you-api
//
//  Created by Roman Derevianko on 24.03.2020.
//  Copyright © 2020 Roman Derevianko. All rights reserved.
//

import Alamofire

public protocol Request {
  var baseURL: String { get }
  var path: String { get }
  var httpMethod: HTTPMethod { get }
  var queryParams: [String: Any]? { get }
  var headers: HTTPHeaders? { get }
  var request: RequestModel { get }
}

public extension Request {
  var queryParams: [String: String]? {
    return nil
  }
  
  var bodyStream: InputStream? {
    return nil
  }
  
  var headers: HTTPHeaders? {
    return nil
  }
  
  var request: RequestModel {
    return RequestModel(self)
  }
}
