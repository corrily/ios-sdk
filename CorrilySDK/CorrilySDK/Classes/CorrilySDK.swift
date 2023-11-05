//
//  CorrilySDK.swift
//  CorrilySDK
//
//  Created by Andrey Filipenkov on 29.10.2023.
//  Copyright © 2023 Corrily, Inc. All rights reserved.
//

import Foundation

public final class CorrilySDK {

    static let shared = CorrilySDK()
    private init() {}

    private var apiClient: CorrilyAPI!
}

public extension CorrilySDK {

    typealias PaywallResponse = (monthlyProducts: [PaywallProduct], yearlyProducts: [PaywallProduct])

    static func start(apiID: String) {
        shared.start(apiID: apiID)
    }

    static func requestPaywall(paywallApiID: String, userID: String?, country: Country, experimentID: Int? = nil, completion: @escaping (PaywallResponse?, Error?) -> Void) {
        shared.requestPaywall(paywallApiID: paywallApiID, userID: userID, country: country, experimentID: experimentID, completion: completion)
    }
}

private extension CorrilySDK {

    func start(apiID: String) {
        apiClient = .init(apiID: apiID)
    }

    func requestPaywall(paywallApiID: String, userID: String?, country: Country, experimentID: Int?, completion: @escaping (PaywallResponse?, Error?) -> Void) {
        guard let apiClient else {
            completion(nil, nil)
            return
        }

        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        guard let payload = try? jsonEncoder.encode(Paywall.Request(
            apiID: paywallApiID,
            userID: userID ?? UserID.userID,
            country: country.rawValue,
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
}
