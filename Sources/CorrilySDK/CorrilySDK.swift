//
//  File.swift
//  CorrilySDK
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation
import SwiftUI

final public class CorrilySDK {
  private static var corrily: CorrilySDK?
  public static var shared: CorrilySDK {
    guard let corrily = corrily else {
      return CorrilySDK()
    }
    return corrily
  }
  
  private let dependencies: DependencyManager
  
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
  static func requestPaywall(userId: String? = nil, country: String, paywallId: Int? = nil) async throws -> PaywallResponse? {
    let dto = PaywallDto(country: country, userId: userId, ip: shared.dependencies.user.userAliasId, paywallId: paywallId)
    return try await shared.dependencies.api.getPaywall(dto)
  }
}

public extension CorrilySDK {
  static func renderPaywall(paywallId: Int? = nil, action: (() -> Void)? = nil, customView: ((_: FactoryProtocol) -> any View)? = nil) -> some View {
    if let customView = customView {
      return AnyView(customView(shared.dependencies))
    }
    return AnyView(PaywallView(factory: shared.dependencies, onSuccess: action))
  }
}

public extension CorrilySDK {
  static func setFallbackPaywall(with paywall: PaywallResponse) {
    shared.dependencies.paywall.setFallbackPaywall(fallbackPaywall: paywall)
  }
}

public extension CorrilySDK {
  static func setUser(userId: String? = nil, country: String? = nil) {
    shared.dependencies.user.setUser(userId: userId, country: country)
  }
}
