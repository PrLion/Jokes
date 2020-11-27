//
//  DataRaftDelegate.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation
import CoreData
import DataRaft

class _DataRaftDelegate: DataRaftDelegate {
  func dataRaft(_ dataRaft: DataRaft, didCreate context: NSManagedObjectContext) {
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
  }
  
  func dataRaft(_ dataRaft: DataRaft, didCreate model: NSManagedObjectModel) {
    model.entities = model.entities.map { entity in
      guard let type = entity.managedObjectClass else { return entity }
      switch type {
      case let type as ManagedObject.Type:
        type.uniquenessConstraints.forEach {
          entity.uniquenessConstraints.append($0)
        }
      default:
        break
      }
      return entity
    }
  }
}
