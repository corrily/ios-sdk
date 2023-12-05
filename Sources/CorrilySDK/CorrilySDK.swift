//
//  File.swift
//  CorrilySDK
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

final public class CorrilySDK {
  private static var corrily: CorrilySDK?
  public static var shared: CorrilySDK {
    guard let corrily = corrily else {
      return CorrilySDK()
    }
    return corrily
  }
  
  let dependencies: DependencyManager
  
  init(dependencies: DependencyManager = DependencyManager()) {
    self.dependencies = dependencies
  }
  
  private convenience init(apiKey: String) {
    let dependencies = DependencyManager()
    dependencies.config.setApiKey(apiKey: apiKey)
    self.init(dependencies: dependencies)
  }
  
  @discardableResult
  public static func start(apiKey: String) -> CorrilySDK {
    guard corrily == nil else {
      Logger.warn("Corrily.start called multiple times. Please make sure you only call this once on app launch.")
      return shared
    }
    corrily = CorrilySDK(apiKey: apiKey)
    return shared
  }
}

public extension CorrilySDK {
  static func requestPaywall(userId: String, country: String) async throws -> PaywallResponse? {
    let dto = PaywallDto(userId: userId, country: country)
    return try await shared.dependencies.api.getPaywall(dto)
  }
  
  static func requestCharge() {
    // TODO: Not implemented yet!
    Logger.info("Request Charge not implemented yet!")
  }
}
