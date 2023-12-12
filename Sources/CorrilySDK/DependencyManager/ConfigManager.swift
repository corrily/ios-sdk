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
  
  public func setApiKey(apiKey: String) {
    self.apiKey = apiKey
  }
}
