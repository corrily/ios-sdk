//
//  File.swift
//  
//
//  Created by Thành Trang on 10/12/2023.
//

import Foundation

@MainActor
public class PaywallViewModel: ObservableObject {
  let factory: FactoryProtocol
  @Published public var paywall: PaywallResponse? = nil
  @Published public var yearlyProducts: [Product] = []
  @Published public var monthlyProducts: [Product] = []
  @Published private (set) var isLoading: Bool = true
  @Published private (set) var isError: Bool = false
  
  init(factory: FactoryProtocol) {
    self.factory = factory
    Task {
      await self.getPaywall()
    }
  }
  
  public func getPaywall() async {
    self.isError = false
    self.isLoading = true
    do {
      guard let paywall = try await CorrilySDK.requestPaywall(userId: factory.user.userId, country: factory.user.country) else {
        DispatchQueue.main.async {
          self.isLoading = false
        }
        return
      }
      DispatchQueue.main.async {
        var yearly: [Product] = []
        var monthly: [Product] = []
        
        for product in paywall.products {
          if (product.interval == Interval.year) {
            yearly.append(product)
          }
          if (product.interval == Interval.month) {
            monthly.append(product)
          }
        }
        self.yearlyProducts = yearly
        self.monthlyProducts = monthly
        self.paywall = paywall
        self.isLoading = false
      }
    } catch {
      DispatchQueue.main.async {
        self.isError = true
        self.isLoading = false
      }
    }
    
  }
}