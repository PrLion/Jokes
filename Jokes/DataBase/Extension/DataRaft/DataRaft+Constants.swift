//
//  DataRaft+Constants.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import CoreData
import DataRaft

extension DataRaft {
  private static let _delegate = _DataRaftDelegate()
  
  public static let `default` = DataRaft().then {
    do {
      $0.delegate = _delegate
        try $0.configure(type: .sqLite, modelName: "joke", bundle: Bundle.main)
    } catch {
      fatalError(error.localizedDescription)
    }
  }
}
