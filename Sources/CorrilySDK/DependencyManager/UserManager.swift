//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

public class UserManager {
  private (set) var userId: String?
  private (set) var userAliasId: String!
  private (set) var country: String = "US"
  
  var factory: FactoryProtocol
  
  private let userAliasIdKey = "UserAliasId"
  
  init(factory: FactoryProtocol) {
    self.factory = factory
    // Try to get the User Alias Id back from the storage
    if let userAliasId = factory.storage.get(for: userAliasIdKey) {
      // If the value exists
      self.userAliasId = userAliasId
    } else {
      // If the value doesn't exits,
      // generate new alias id with IPV6 format
      let generatedAliasId = self.generateUserAliasId()
      // Write it to the storage
      if factory.storage.set(generatedAliasId, for: userAliasIdKey) {
        self.userAliasId = generatedAliasId
      } else {
        // TODO: Handle case when userAliasId can't save to the storage
      }
    }
  }
  
  private func generateUserAliasId() -> String {
    var parts: [String] = []
    for _ in 1...8 {
      parts.append(String(format: "%X", arc4random_uniform(65536)))
    }

    return parts.joined(separator: ":")
  }
  
  public func setUser(userId: String, country: String? = nil) {
    self.userId = userId
    self.country = country ?? "US"
  }
}
