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
  let onSuccess: (() -> Void)?
  
  @Published public private(set) var isLoading = true
  @Published public private(set) var isError = false
  @Published public private(set) var errorMessage: String? = nil
  
  @Published public var paywall: PaywallResponse? = nil
  @Published public var yearlyProducts: [Product] = []
  @Published public var monthlyProducts: [Product] = []
  
  public init(paywallId: Int? = nil, onSuccess: (() -> Void)? = nil, factory: FactoryProtocol) {
    self.factory = factory
    self.onSuccess = onSuccess
    Task {
      await self.getPaywall(paywallId: paywallId)
    }
  }

  public func purchase(product: Product) {
    isError = false
    errorMessage = nil
    Task {
      do {
        try await Purchase.shared.purchase(product.apiId.replacingOccurrences(of: "+", with: ""))
        if (onSuccess != nil) {
          onSuccess!()
        }
      } catch {
        isError = true
        errorMessage = error.localizedDescription
      }
    }
  }
  
  public func restorePurchase() {
    Task {
      do {
        try await Purchase.shared.restorePurchase()
      } catch {
        Logger.error("Can not restore purchase")
      }
    }
  }
  
  func getPaywall(paywallId: Int? = nil) async {
    isError = false
    isLoading = true
    
    do {
      let dto = PaywallDto(
        country: factory.user.country,
        userId: factory.user.userId,
        ip: factory.user.deviceId,
        paywallId: paywallId
      )
      let response = try await factory.api.getPaywall(dto)
      
      yearlyProducts = response.products.filter { $0.interval == .year }
      monthlyProducts = response.products.filter { $0.interval == .month }
      paywall = response
      isLoading = false
      
    } catch HttpError.clientError(let clientError) {
      // Handle load fallback paywall for some http status code
      isError = true
      errorMessage = clientError.errorMessage
      isLoading = false
      
    } catch {
      if let fallbackPaywall = factory.paywall.fallbackPaywall {
        Logger.info("Can NOT get paywall from API. Using data from fallback.")
        paywall = fallbackPaywall
        yearlyProducts = fallbackPaywall.products.filter { $0.interval == .year }
        monthlyProducts = fallbackPaywall.products.filter { $0.interval == .month }
        isLoading = false
      } else {
        Logger.error("Can NOT fetch paywall", trace: error)
        isError = true
        isLoading = false
      }
    }
  }
}
