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
  @Published public private (set) var errorMessage: String? = nil
  
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
      let dto = PaywallDto(country: factory.user.country,userId: factory.user.userId, ip: factory.user.userAliasId,paywallId: paywallId)
      let response = try await factory.api.getPaywall(dto)
      DispatchQueue.main.async {
        var yearly: [Product] = []
        var monthly: [Product] = []
        
        for product in response.products {
          if (product.interval == Interval.year) {
            yearly.append(product)
          }
          if (product.interval == Interval.month) {
            monthly.append(product)
          }
        }
        self.yearlyProducts = yearly
        self.monthlyProducts = monthly
        self.paywall = response
        self.isLoading = false
      }
    } catch HttpError.clientError(let clientError) {
      // FIXME: Handle load fallback paywall for some http status code
      // Other errors should be rendered in UI
      DispatchQueue.main.async {
        self.isError = true
        self.isLoading = false
        self.errorMessage = clientError.errorMessage
      }
    } catch {
      DispatchQueue.main.async {
        self.isError = true
        self.isLoading = false
      }
    }
  }
}
