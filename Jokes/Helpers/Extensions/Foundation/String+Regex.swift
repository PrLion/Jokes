//
//  String+Regex.swift
//  Jokes
//
//  Created by mac on 10.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public extension String {
  func replacingMatches(regex: String, with string: String) -> String {
    return replacingOccurrences(of: regex, with: string, options: .regularExpression, range: nil)
  }
  
  func substringMatches(regex: String) throws -> [String] {
    let regex = try NSRegularExpression(pattern: regex, options: [])
    let range = NSMakeRange(0, (self as NSString).length)
    let matches = regex.matches(in: self, options: [], range: range)
    
    let string = self as NSString
    var substrings = [String]()
    for match in matches {
      substrings.append(string.substring(with: match.range) as String)
    }
    
    return substrings
  }
  
  func isMatches(regex: String) throws -> Bool {
    return isMatches(regex: try NSRegularExpression(pattern: regex, options: []))
  }
  
  func isMatches(regex: NSRegularExpression) -> Bool {
    let range = NSMakeRange(0, (self as NSString).length)
    return !regex.matches(in: self, options: [], range: range).isEmpty
  }
}
