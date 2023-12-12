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
  @Published public private (set) var isLoading: Bool = true
  @Published public private (set) var isError: Bool = false
  
  @Published public var paywall: PaywallResponse? = nil
  @Published public var yearlyProducts: [Product] = []
  @Published public var monthlyProducts: [Product] = []
  
  public init(paywallId: Int? = nil, factory: FactoryProtocol) {
    self.factory = factory
    Task {
      await self.getPaywall(paywallId: paywallId)
    }
  }
  
  func getPaywall(paywallId: Int? = nil) async {
    self.isError = false
    self.isLoading = true
    do {
      guard let paywall = try await CorrilySDK.requestPaywall(userId: factory.user.userId, country: factory.user.country, paywallId: paywallId) else {
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
