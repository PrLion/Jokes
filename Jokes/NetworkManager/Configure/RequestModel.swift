//
//  RequestModel.swift
//  pick4you-api
//
//  Created by Roman Derevianko on 24.03.2020.
//  Copyright © 2020 Roman Derevianko. All rights reserved.
//

import Alamofire
import PromiseKit

public class RequestModel {
  var requestURL: URL
  var header: HTTPHeaders?
  var httpMethod: HTTPMethod
  var queryParams: [String: Any]?
  
  init(_ request: Request) {
    let url: URL = {
      var components = URLComponents(string: request.baseURL)
      components?.path = request.path + "/"
      guard let url = components?.url else { fatalError() }
      return url
    }()
    
    self.requestURL = url
    self.httpMethod = request.httpMethod
    self.header = request.headers
    self.queryParams = request.queryParams
  }
}
