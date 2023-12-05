//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

struct UserManager {
  var userId: String
  var deviceId: String
  
  func generateDeviceId() -> String {
    var parts: [String] = []
    for _ in 1...8 {
      parts.append(String(format: "%X", arc4random_uniform(65536)))
    }

    return parts.joined(separator: ":")
  }
}
