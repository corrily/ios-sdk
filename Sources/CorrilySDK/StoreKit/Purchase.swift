//
//  File.swift
//  
//
//  Created by Thành Trang on 21/12/2023.
//

import Foundation

public class Purchase {
  public static let shared = Purchase()
  
  public func purchase(_ productId: String) async throws {
    if #available(iOS 15, *) {
      try await StoreKit2Manager.shared.purchase(productId)
    } else {
      Logger.error("Not supported iOS below 15 yet!")
    }
  }
  
  public func restorePurchase() async {
    if #available(iOS 15, *) {
      try await StoreKit2Manager.shared.restorePurchase()
    } else {
      Logger.error("Not supported iOS below 15 yet!")
    }
  }
}
