//
//  HTTPProvider.swift
//  pick4you-api
//
//  Created by Roman Derevianko on 27.03.2020.
//  Copyright © 2020 Roman Derevianko. All rights reserved.
//

import PromiseKit
import Alamofire

public enum HTTPError: Error {
  case unexpected
}

public struct Provider<R: HTTPRequest> {
  let sessionManager: Session
  
  init(sessionManager: Session = .default) {
    self.sessionManager = sessionManager
  }
  
  func dataRequest(_ request: R) -> Promise<Data> {
    return Promise { seal in
      
      print("=================================================")
      print("||\(request.request.requestURL)||")
      print("||\(request.request.httpMethod)||")
      print("||\(request.request.queryParams ?? [:])||")
      print("||\(request.request.header ?? [:])||")
      print("================================================= \n")
      
      AF.request(request.request.requestURL, method: request.request.httpMethod, parameters: request.request.queryParams, encoding: URLEncoding.default, headers: request.request.header).validate().responseJSON { response in
        print("================RESPONSE================ \n")
        print(try! JSONSerialization.jsonObject(with: response.data!) as! [String: Any], "\n")
        print("======================================== ")
        switch response.result {
        case .success(let data):
          seal.fulfill(try! JSONSerialization.data(withJSONObject: data))
        case .failure(let error):
          if response.response?.statusCode == 400 {
            let userInfo = try! JSONSerialization.jsonObject(with: response.data!) as! [String: Any]
            seal.reject(NSError(domain: Bundle.main.bundleIdentifier!, code: 400, userInfo: userInfo))
          } else {
            seal.reject(error)
          }
        }
      }
    }
  }
}

public struct HTTPProvider<R: HTTPRequest> {
  let provider: Provider<R>
  
  init(provider: Provider<R> = .init()) {
    self.provider = provider
  }
  
  public func dataRequest(_ request: R) -> Promise<Data> {
    return provider.dataRequest(request)
  }
}
