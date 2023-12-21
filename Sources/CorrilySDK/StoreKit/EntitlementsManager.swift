//
//  File.swift
//  
//
//  Created by Thành Trang on 20/12/2023.
//

import Foundation

@MainActor
public class EntitlementsManager: ObservableObject {
  public static let shared = EntitlementsManager()
  
  @Published public private(set) var productIds: Set<String> = Set()
  @Published public private(set) var hasSubscription = false
  
  public func addProduct(_ productId: String) {
    productIds.insert(productId)
    hasSubscription = !productIds.isEmpty
  }
  
  public func removeProduct(_ productId: String) {
    productIds.remove(productId)
    hasSubscription = !productIds.isEmpty
  }
}
