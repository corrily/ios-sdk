//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

final class DependencyManager {
  var config: ConfigManager!
  var api: API!
  
  init() {
    config = ConfigManager()
    api = API(factory: self)
  }
}

extension DependencyManager: FactoryProtocol {}
