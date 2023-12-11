//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

public class ConfigManager {
  
//  enum Channel {
//    case production
//    case staging
//    case develop
//    
//    var baseUrl: String {
//      switch self {
//      case .production:
//        return "client.corrily.com/v1"
//      case .staging:
//        return "client.corrily.com"
//      case .develop:
//        return "client.corrily.com"
//      }
//    }
//  }
//  var channel: Channel = .production
  
  private (set) var apiKey: String = ""
  private (set) var baseUrl: String = "client.corrily.com"
  
  private (set) var defaultPricingPage: PricingPage?
  private (set) var fallbackProducts: [Product]?
  
  public func setApiKey(apiKey: String) {
    self.apiKey = apiKey
  }
  public func setFallbackProducts(with products: [Product]) {
    self.fallbackProducts = products
  }
  public func setDefaultPricingPage(with pricingPage: PricingPage) {
    self.defaultPricingPage = pricingPage
  }
}
