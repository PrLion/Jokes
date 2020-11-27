//
//  CRUDService.swift
//  Jokes
//
//  Created by mac on 11.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import Foundation
import PromiseKit

public enum CRUDServiceError: Error {
  case dbError(_ error: Error)
  
}

public enum Result<M: CRUDModel> {
  case created(_ models: [M])
  case obtained(_ models: [M])
  case updated(_ models: [M])
  case deleted(_ models: [M])
  case error(_ error: CRUDServiceError)
}

public final class CRUDService<M: CRUDModel> {
  public typealias Observer = (Result<M>) -> ()
  
  public var observer: Observer?
  private let dbService: DBService<M.DBModels>
  
  init(dbService: DBService<M.DBModels>) {
    self.dbService = dbService
    self.dbService.observer = { [unowned self] in
      switch $0 {
      case .created(let models): self.observer?(.created(models.map { M(with: $0) }))
      case .updated(let models): self.observer?(.updated(models.map { M(with: $0) }))
      case .deleted(let models): self.observer?(.deleted(models.map { M(with: $0) }))
      }
    }
  }
}

public extension CRUDService {
  func read(_ request: M.DBModels.FetchType? = nil) {
    firstly {
      read(request)
    }.done {
      self.observer?(.obtained($0))
    }.catch {
      self.observer?(.error(.dbError($0)))
    }
  }
  
  func read(_ request: M.DBModels.FetchType? = nil) -> Promise<[M]> {
    return Promise { seal in
      firstly {
        dbService.fetch(request)
      }.compactMap {
        $0.map { M(with: $0) }
      }.done {
        seal.fulfill($0)
      }.catch {
        seal.reject($0)
      }
    }
  }
  
  func create(_ models: [M]) {
    firstly {
      create(models)
    }.catch {
      self.observer?(.error(.dbError($0)))
    }
  }
  
  func create(_ models: [M]) -> Promise<Void> {
    return Promise { seal in
      firstly {
        dbService.create(models as! [M.DBModels.CRUDType])
      }.done {
        seal.fulfill(())
      }.catch {
        seal.reject($0)
      }
    }
  }
  
  func update(_ models: [M]) {
    firstly {
      dbService.update(models as! [M.DBModels.CRUDType])
    }.catch {
      self.observer?(.error(.dbError($0)))
    }
  }
  
  func update(_ models: [M]) -> Promise<Void> {
    return Promise { seal in
      firstly {
        dbService.update(models as! [M.DBModels.CRUDType])
      }.done {
        seal.fulfill(())
      }.catch {
        seal.reject($0)
      }
    }
  }
  
  func delete(_ models: [M]) {
    delete(models.compactMap { $0.id }) as Void
  }
  
  func delete(_ models: [M]) -> Promise<Void> {
    return delete(models.compactMap { $0.id })
  }
  
  func delete(_ ids: [Int32]) {
    firstly {
      delete(ids)
    }.catch {
      self.observer?(.error(.dbError($0)))
    }
  }
  
  func delete(_ ids: [Int32]) -> Promise<Void> {
    return Promise { seal in
      firstly {
        dbService.delete(ids)
      }.done {
        seal.fulfill(())
      }.catch {
        seal.reject($0)
      }
    }
  }
}
