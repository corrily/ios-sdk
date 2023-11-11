//
//  CorrilySDK.swift
//  CorrilySDK
//
//  Created by Andrey Filipenkov on 29.10.2023.
//  Copyright © 2023 Corrily, Inc. All rights reserved.
//

import Foundation
import StoreKit

public final class CorrilySDK {

    static let shared = CorrilySDK()
    private init() {}

    private var apiClient: CorrilyAPI?
}

public extension CorrilySDK {

    typealias PaywallResponse = (monthlyProducts: [PaywallProduct], yearlyProducts: [PaywallProduct])

    /// SDK entry point
    /// - Parameter apiKey: Your API key
    static func start(apiKey: String) {
        shared.start(apiKey: apiKey)
    }

    /// Perform Paywall request to obtain list of products
    /// - Parameters:
    ///   - userID: Some ID to identify current user. If `nil` is passed, SDK will try to use IDFA if available or an internally generated UUID.
    ///   - country: User's country
    ///   - isDev: Flag used for testing, set to `true`
    ///   - experimentID: Experiment ID from Corrily dashboard
    ///   - completion: Completion closure to receive results
    static func requestPaywall(userID: String?, country: Country, isDev: Bool, experimentID: Int? = nil, completion: @escaping (PaywallResponse?, Error?) -> Void) {
        shared.requestPaywall(userID: userID, country: country, isDev: isDev, experimentID: experimentID, completion: completion)
    }

    /// Perform Charge request to notify Corrily of a purchase action. https://docs.corrily.com/api-reference/create-charge
    /// - Parameters:
    ///   - transaction: Transaction object from StoreKit
    ///   - product: Product object that is being purchased
    ///   - paywallProduct: Corrily product returned from `requestPaywall`
    ///   - userID: Same as in `requestPaywall`
    ///   - country: Same as in `requestPaywall`
    static func requestCharge(transaction: SKPaymentTransaction, product: SKProduct, paywallProduct: PaywallProduct, userID: String?, country: Country) {
        shared.requestCharge(transaction: transaction, product: product, paywallProduct: paywallProduct, userID: userID, country: country)
    }
}

private extension CorrilySDK {

    func start(apiKey: String) {
        apiClient = .init(apiKey: apiKey)
    }

    func requestPaywall(userID: String?, country: Country, isDev: Bool, experimentID: Int?, completion: @escaping (PaywallResponse?, Error?) -> Void) {
        guard let apiClient else {
            completion(nil, nil)
            return
        }

        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        guard let payload = try? jsonEncoder.encode(Paywall.Request(
            apiID: apiClient.apiKey,
            userID: userID ?? UserID.userID,
            country: country.rawValue,
            dev: isDev,
            experimentID: experimentID
        )) else {
            completion(nil, nil)
            return
        }

        apiClient.call(endpoint: "paywall", payload: payload) {
            guard let data = $0 else {
                completion(nil, $1)
                return
            }

            let response: Paywall.Response
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                response = try jsonDecoder.decode(Paywall.Response.self, from: data)
                guard response.success else {
                    completion(nil, nil)
                    return
                }
            } catch {
                completion(nil, error)
                return
            }

            var monthlyProducts = [PaywallProduct]()
            var yearlyProducts = [PaywallProduct]()
            response.products.forEach {
                let product = PaywallProduct(
                    appStoreConnectID: $0.apiId,
                    corrilyID: $0.id,
                    name: $0.name,
                    intervalCount: $0.intervalCount,
                    price: $0.price,
                    priceUSD: $0.priceUsd
                )
                switch $0.interval {
                case .month:
                    monthlyProducts.append(product)
                case .year:
                    yearlyProducts.append(product)
                }
            }
            completion(PaywallResponse(monthlyProducts: monthlyProducts, yearlyProducts: yearlyProducts), nil)
        }
    }

    func requestCharge(transaction: SKPaymentTransaction, product: SKProduct, paywallProduct: PaywallProduct, userID: String?, country: Country) {
        guard let apiClient else { return }

        let status: String
        switch transaction.transactionState {
        case .purchasing, .deferred:
            status = "pending"
        case .purchased, .restored:
            status = "succeeded"
        case .failed:
            guard (transaction.error as? SKError)?.code != .paymentCancelled else { return }
            status = "failed"
        @unknown default:
            return
        }

        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        jsonEncoder.dateEncodingStrategy = .secondsSince1970
        guard let payload = try? jsonEncoder.encode(ChargeRequest(
            amount: product.price.doubleValue,
            created: transaction.transactionDate ?? .init(),
            currency: product.priceLocale.currencyCode ?? "USD",
            country: country.rawValue,
            origin: "ios",
            originID: transaction.transactionIdentifier ?? "",
            product: "\(paywallProduct.corrilyID)",
            status: status,
            userID: userID ?? UserID.userID
        )) else { return }

        apiClient.call(endpoint: "charges", payload: payload) { _, _ in
        }
    }
}
