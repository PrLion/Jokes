//
//  SwitchableCell.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import UIKit

class SwitchableCell: UITableViewCell, Reusable, NibRepresentable {
    typealias SwitchAction = (Bool) -> Void
    
    // MARK: - Outlets
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var `switch`: UISwitch!
    
    // MARK: - Properties
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var state: Bool {
        get { return `switch`.isOn }
        set { `switch`.isOn = newValue }
    }
    
    var switchAction: SwitchAction = { _ in }
    
    var switchState: Bool {
        get { return `switch`.isOn }
        set { `switch`.isOn = newValue }
    }
    
    // MARK: - Lifecycle
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        `switch`.addAction(for: .valueChanged, action: { [unowned self] in self.switchAction($0.isOn) })
    }
}
