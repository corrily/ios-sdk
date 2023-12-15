//
//  File.swift
//  
//
//  Created by Thành Trang on 12/12/2023.
//

import Foundation

public class PaywallManager {
  let factory: FactoryProtocol
  private (set) var fallbackPaywall: PaywallResponse? = nil
  private (set) var prefetchedPaywall: PaywallResponse? = nil
  
  init(factory: FactoryProtocol) {
    self.factory = factory
  }
  
  public func setFallbackPaywall(_ jsonString: String) {
    let data = Data(jsonString.utf8)
    let decoder = JSONDecoder.fromSnakeCase
    
    do {
      let paywall = try decoder.decode(PaywallResponse.self, from: data)
      Logger.info("Set fallback paywall")
      self.fallbackPaywall = paywall
    } catch {
      Logger.error("Can not decode the fallback paywall")
    }
  }
  
  public func prefetchPaywall() {
    
  }
}
