//
//  JokesAPI.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation
import Alamofire

public enum JokeMethod {
  case jokelist
  case code(phone: String, code: String)
  case signup(phone: String, password: String)
  case login(phone: String, password: String, useragent: String, fingerprint: String)
  case refreshToken(refreshToken: String, fingerprint: String)
  case destroy
}

public struct JokePath: PathComponent {
  public static var jokes = JokePath("jokes")
  
  public var rawValue: CustomStringConvertible
  
  public init(_ rawValue: CustomStringConvertible) {
    self.rawValue = rawValue
  }
}

public class JokeRequest: HTTPRequest {
  public typealias PathType = JokePath
  public typealias APIMethod = JokeMethod
  
  public var apiMethod: APIMethod
  public var token: String?
  public var baseURL: String
  
    public required init(apiMethod: JokeMethod, baseURL: String = config.baseUrl) {
    self.apiMethod = apiMethod
    self.baseURL = baseURL
  }
  
  public var httpMethod: HTTPMethod {
    switch apiMethod {
    case .jokelist, .code, .signup, .login, .refreshToken: return .get
    case .destroy: return .delete
    }
  }
  
  public var pathComponents: [JokePath] {
    switch apiMethod {
    case .jokelist: return [.jokes]
    default: return []
//    case .code: return [.entity, .apiVersion, .oauth, .code]
//    case .signup: return [.entity, .apiVersion, .oauth, .signup]
//    case .login: return [.entity, .apiVersion, .oauth, .login]
//    case .refreshToken: return [.entity, .apiVersion, .oauth, .refreshToken]
//    case .destroy: return [.entity, .apiVersion, .oauth, .deleteSession]
    }
  }
  
  public var queryParams: [String : Any]? {
    switch apiMethod {
    case .jokelist: return [:]
    case let .code(phone, code): return ["phone": phone, "otp": code]
    case let .signup(phone, password): return ["phone": phone, "password": password]
    case let .login(phone, password, useragent, fingerprint): return ["phone": phone, "password": password, "userAgent": useragent, "fingerprint": fingerprint]
    case let .refreshToken(refreshToken, fingerprint): return ["refresh": refreshToken, "fingerprint": fingerprint]
    default: return [:]
    }
  }
}
