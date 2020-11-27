//
//  DBService.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation
import PromiseKit
import DataRaft
import CoreData

public enum Items<M: DBModel> {
  case created(_ models: [M])
  case updated(_ models: [M])
  case deleted(_ models: [M])
}

public final class DBService<M: DBModel> {
  public typealias Observer = (Items<M>) -> ()
  
  public var observer: Observer?
  private let db: DataRaft
  
  init(db: DataRaft) {
    self.db = db
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(didSave(_:)),
      name: .NSManagedObjectContextDidSave,
      object: db.main()
    )
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func didSave(_ notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    
    let ins = (userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>)?.compactMap { $0 as? M } ?? []
    let upd = (userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>)?.compactMap { $0 as? M } ?? []
    let del = (userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject>)?.compactMap { $0 as? M } ?? []
    
    if !ins.isEmpty { observer?(.created(ins)) }
    if !upd.isEmpty { observer?(.updated(upd)) }
    if !del.isEmpty { observer?(.deleted(del)) }
  }
}

public extension DBService {
  func fetch(_ request: M.FetchType?) -> Promise<[M]> {
    return Promise { seal in
      db.performOnMain {
        do {
          let models: [M] = try $0.fetch(predicate: request?.predicate, sortDescriptors: request?.sortDescriptors)
          seal.fulfill(models)
        } catch {
          seal.reject(error)
        }
      }
    }
  }
  
  func create(_ models: [M.CRUDType]) -> Promise<Void> {
    return Promise { seal in
      db.performOnPrivate { ctx in
        do {
          try models.forEach {
            let model = M(context: ctx)
            try model.map(with: $0)
          }
          
          try ctx.saveToStore()
          seal.fulfill(())
        } catch {
          seal.reject(error)
        }
      }
    }
  }
  
  func update(_ models: [M.CRUDType]) -> Promise<Void> {
    return Promise { seal in
      db.performOnPrivate {
        do {
          let ids = models.map { ($0 as! AnyModel).id }
          let predicate = NSPredicate(format: "%K IN %@", "id", ids)
          let dbModels: [M] = try $0.fetch(predicate: predicate)
          
          try dbModels.forEach { dbModel in
            if let model = models.first(where: { ($0 as! AnyModel).id == dbModel.id }) {
              try dbModel.map(with: model)
            }
          }
          
          try $0.saveToStore()
          seal.fulfill(())
        } catch {
          seal.reject(error)
        }
      }
    }
  }
  
  func delete(_ ids: [Int32]) -> Promise<Void> {
    return Promise { seal in
      db.performOnPrivate {
        do {
          let predicate = NSPredicate(format: "%K IN %@", "id", ids)
          let models: [M] = try $0.fetch(predicate: predicate)
          for model in models { $0.delete(model) }
          try $0.saveToStore()
          seal.fulfill(())
        } catch {
          seal.reject(error)
        }
      }
    }
  }
}
