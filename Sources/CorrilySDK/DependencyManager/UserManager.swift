//
//  File.swift
//
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation
import StoreKit

public class UserManager {
  private (set) var userId: String?
  private (set) var deviceId: String!
  private (set) var country: String!
  
  var factory: FactoryProtocol
  
  private let deviceIdKey = "UserDeviceId"
  
  init(factory: FactoryProtocol) {
    self.factory = factory
    // Try to get the User Alias Id back from the storage
    if let deviceId = factory.storage.get(for: deviceIdKey) {
      // If the value exists
      self.deviceId = deviceId
    } else {
      // If the value doesn't exits,
      // generate new alias id with IPV6 format
      let generatedDeviceId = self.generateDeviceId()
      // Write it to the storage
      if factory.storage.set(generatedDeviceId, for: deviceIdKey) {
        self.deviceId = generatedDeviceId
      } else {
        // TODO: Handle case when userAliasId can't save to the storage
      }
    }
    if let countryCode = CountryCodeHelper().getCountryCode() {
      self.country = countryCode
    } else {
      Logger.warn("Using default countryCode: XX")
      self.country = "XX"
    }
  }
  
  private func generateDeviceId() -> String {
    var parts: [String] = []
    for _ in 1...8 {
      parts.append(String(format: "%X", arc4random_uniform(65536)))
    }
    
    return parts.joined(separator: ":")
  }
  
  public func setUser(userId: String? = nil, country: String? = nil, disableIdentificationRequest: Bool = false) {
    self.userId = userId
    if (country != nil) {
      self.country = country!
    }
    
    if (!disableIdentificationRequest) {
      Task.detached {
        if (userId == nil) {
          return
        }
        let dto = IdentifyDto(userId: userId!, ip: self.factory.user.deviceId, country: country)
        do {
          try await self.factory.api.identifyUser(dto)
        } catch {
          Logger.error("Cannot setUserIdentify for \(userId!) with \(self.factory.user.deviceId!)", trace: error)
        }
      }
    }
  }
  
}
