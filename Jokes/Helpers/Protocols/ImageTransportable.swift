//
//  ImageTransportable.swift
//  Jokes
//
//  Created by mac on 10.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import UIKit.UIImage

public protocol ImageTransportable where Self: RawRepresentable {
  var image: UIImage! { get }
}

extension ImageTransportable {
  public var image: UIImage! {
    return UIImage(named: rawValue as! String, in: Bundle.main, compatibleWith: nil)
  }
}
