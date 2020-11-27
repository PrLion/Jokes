//
//  TextFieldCell.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell, Reusable, NibRepresentable {
    typealias Action = (String?) -> Void
    
    // MARK: - Outlets
    
    @IBOutlet private var textField: UITextField!
    
    // MARK: - Properties
    
    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    var textValue: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    var textChanged: Action = {_ in}
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        textField.addAction(for: .editingChanged, action: { [unowned self] in self.textChanged($0.text) } )
    }
    
    // MARK: - Actions
    
    @objc private func textFieldChanged() {
        
    }
}
