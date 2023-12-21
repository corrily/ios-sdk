//
//  File.swift
//
//
//  Created by Thành Trang on 20/12/2023.
//

import Foundation
import StoreKit

@available(iOS 15, *)
public class StoreKit2Manager {
  static let shared = StoreKit2Manager()
  let entitlementManager = EntitlementsManager.shared
  
  private var transactionListener: Task<Void, Error>?
  
  init() {
    transactionListener = listenForTransaction()
  }
  
  deinit {
    transactionListener?.cancel()
  }
  
  func purchase(_ productId: String) async throws -> PurchaseResult {
    guard let product = try await getProduct(productId) else {
      throw PurchaseError.invalidProductId
    }
    
    let result = try await product.purchase()
    switch result {
    case .success(let verification):
      guard let transaction = try verifyTransaction(verification) else {
        throw PurchaseError.invalidTransaction
      }
      await transaction.finish()
      await restorePurchase()
      return PurchaseResult.success
    case .pending:
      return PurchaseResult.pending
    case .userCancelled:
      return PurchaseResult.cancelled
    }
  }
  
  func restorePurchase() async {
    for await result in StoreKit.Transaction.currentEntitlements {
      do {
        guard let transaction = verifyTransaction(result) else {
          continue
        }
        if (transaction.revocationDate == nil) {
          await entitlementManager.addProduct(transaction.productID)
        } else {
          await entitlementManager.removeProduct(transaction.productID)
        }
        await transaction.finish()
      } catch {}
    }
  }
  
  private func verifyTransaction<TResult>(_ result: VerificationResult<TResult>) -> TResult? {
    switch result {
    case .unverified:
      return nil
    case .verified(let transaction):
      return transaction
    }
  }
  
  private func listenForTransaction() -> Task<Void, Error> {
    return Task.detached(priority: .background) {
      
      for await result in StoreKit.Transaction.updates {
        do {
          guard let transaction = try self.verifyTransaction(result) else {
            continue
          }
          await self.restorePurchase()
        }
      }
    }
  }
  
  private func getProduct(_ productId: String) async throws -> StoreKit.Product? {
    guard let product = try await StoreKit.Product.products(for: [productId]).first else {
      return nil
    }
    return product
  }
}

enum PurchaseResult {
  case success
  case failure
  case pending
  case cancelled
}

enum PurchaseError: LocalizedError {
  case invalidTransaction
  case invalidProductId
  
  var description: String? {
    switch self {
    case .invalidTransaction: return NSLocalizedString("Invalid Transaction", comment: "")
    case .invalidProductId: return NSLocalizedString("Invalid Product Id", comment: "")
    }
  }
}
