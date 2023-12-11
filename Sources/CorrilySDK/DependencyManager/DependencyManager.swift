//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

final class DependencyManager {
  private (set) var config: ConfigManager!
  private (set) var api: API!
  private (set) var storage: StorageManager!
  private (set) var user: UserManager!
  
  private let storageServiceKey = "CorrilySDK"
  
  init() {
    config = ConfigManager()
    storage = StorageManager(service: storageServiceKey)
    api = API(factory: self)
    user = UserManager(factory: self)
  }
}

extension DependencyManager: FactoryProtocol {}
