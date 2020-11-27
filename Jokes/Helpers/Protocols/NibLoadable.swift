//
//  NibLoadable.swift
//  Jokes
//
//  Created by mac on 10.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import UIKit

public protocol NibLoadable: NibRepresentable {
  func loadNib(_ nib: UINib) -> UIView?
}

public extension NibLoadable where Self: UIView {
  @discardableResult
  func loadNib(_ nib: UINib) -> UIView? {
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
    else { return nil }
    
    addSubview(view)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.frame = bounds
    
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
    ])
    
    return view
  }
}
