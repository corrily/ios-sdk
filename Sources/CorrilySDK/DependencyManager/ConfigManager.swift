//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

public class ConfigManager {
  
  enum Channel {
    case production
    case staging
    case develop
    
    var baseUrl: String {
      switch self {
      case .production:
        return "https://client.corrily.com"
      case .staging:
        return "https://default.corrily.com/mainapi"
      case .develop:
        return "client.corrily.com"
      }
    }
  }
  var channel: Channel = .staging
  
  private (set) var apiKey: String = ""
  
  public func setApiKey(apiKey: String) {
    self.apiKey = apiKey
  }
}
