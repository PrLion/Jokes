//
//  JokeListModel.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

struct JokeListModel: Codable {
    var type: String?
    var value: Array<JokeCRUDModel>
}
