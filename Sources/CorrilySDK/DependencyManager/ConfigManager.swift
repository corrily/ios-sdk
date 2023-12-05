//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

class ConfigManager {
  
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
  
  var apiKey: String = ""
  var baseUrl: String = "client.corrily.com"

  
  init() {}
  
  public func setApiKey(apiKey: String) {
    Logger.info("set Api Key with \(apiKey)")
    self.apiKey = apiKey
  }
}
