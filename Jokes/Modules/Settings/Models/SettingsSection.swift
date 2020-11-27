//
//  SettingsSection.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation

struct SettingsSection {
    var items: [SettingsItem]
}

enum SettingsItem {
    typealias TextAction = TextFieldCell.Action
    typealias SitchAction = SwitchableCell.SwitchAction
    
    case textfield(placeholder: String?, text: String?, textAction: TextAction)
    case switchable(title: String?, state: Bool, action: SitchAction)
}
