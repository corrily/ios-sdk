//
//  File.swift
//  
//
//  Created by Thành Trang on 10/12/2023.
//

import Foundation

public class StorageManager {
  let service: String

  init(service: String) {
    self.service = service
  }

  public func set(_ value: String, for account: String) -> Bool {
    guard let data = value.data(using: .utf8) else { return false }

    let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                kSecAttrAccount as String: account,
                                kSecAttrService as String: service,
                                kSecValueData as String: data]

    SecItemDelete(query as CFDictionary)

    let status = SecItemAdd(query as CFDictionary, nil)
    return status == errSecSuccess
  }

  public func get(for account: String) -> String? {
    let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                kSecAttrAccount as String: account,
                                kSecAttrService as String: service,
                                kSecReturnData as String: kCFBooleanTrue!,
                                kSecMatchLimit as String: kSecMatchLimitOne]

    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

    if status == errSecSuccess {
      if let retrievedData = dataTypeRef as? Data,
         let dataString = String(data: retrievedData, encoding: .utf8) {
        return dataString
      }
    }
    return nil
  }
}
