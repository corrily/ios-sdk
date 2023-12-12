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
  
  public func setFallbackPaywall(fallbackPaywall: PaywallResponse) {
    self.fallbackPaywall = fallbackPaywall
  }
  
  public func prefetchPaywall() {
    
  }
}
