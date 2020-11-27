//
//  UserInfo.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

class UserInfo {
    
    static var shared = UserInfo()
    
    var offlineMode: Bool {
        get { UserDefaults.standard.bool(forKey: "offlineMode") }
        set { UserDefaults.standard.set(newValue, forKey: "offlineMode") }
    }
}
