//
//  JokeListSection.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

struct JokeListSection {
    var header: String?
    var items: [JokeListItem]
}

enum JokeListItem {
    typealias Action = JokeCell.Action
    
    case joke(id: Int, joke: String?, isLike: Bool = false, shareAction: Action, likeAction: Action, deleteAction: Action)
}
