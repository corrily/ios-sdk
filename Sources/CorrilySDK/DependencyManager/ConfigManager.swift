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
    
    var baseUrl: String {
      switch self {
      case .production:
        return "https://client.corrily.com"
      case .staging:
        return "https://staging.corrily.com/mainapi"
      }
    }
  }
  var channel: Channel = .production
  
  private (set) var apiKey: String = ""
  
  public func setApiKey(apiKey: String) {
    self.apiKey = apiKey
  }
}
