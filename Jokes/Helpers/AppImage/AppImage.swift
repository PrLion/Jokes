//
//  AppImage.swift
//  Jokes
//
//  Created by mac on 10.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

public struct AppImage {
    public enum Tabbar: String, ImageTransportable {
        case myJokes = "myJoke"
        case jokeList = "list"
        case settings = "settings"
    }
    
    public enum Button: String, ImageTransportable {
        case share = "share"
        case like = "like"
        case likeFill = "like.fill"
        case delete = "delete"
    }
}
