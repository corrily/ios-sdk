//
//  CorrilyAPI.swift
//  CorrilySDK
//
//  Created by Andrey Filipenkov on 30.10.2023.
//  Copyright © 2023 Corrily, Inc. All rights reserved.
//

import Foundation

struct Paywall {
    struct Request: Encodable {
        let apiID: String
        let userID: String
        let country: String
        let dev: Bool
        let experimentID: Int?
    }

    struct Response: Decodable {
        let success: Bool
        let products: [Product]

        struct Product: Decodable {
            let id: Int
            let name: String
            let interval: Interval
            let intervalCount: Int
            let apiId: String
            let price: String
            let priceUsd: String

            enum Interval: String, Decodable {
                case month
                case year
            }
        }
    }
}

public struct PaywallProduct {
    public let appStoreConnectID: String
    public let corrilyID: Int
    public let name: String
    public let intervalCount: Int
    public let price: String
    public let priceUSD: String
}

struct ChargeRequest: Encodable {
    let amount: Double
    let created: Date
    let currency: String
    let country: String
    let origin: String
    let originID: String
    let product: String
    let status: String
    let userID: String
}

final class CorrilyAPI {

    private let urlSession: URLSession

	init(apiID: String) {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json",
            "x-api-key": apiID,
        ]

        urlSession = URLSession(configuration: config)
    }

	func call(endpoint: String, payload: Data, completion: @escaping (Data?, Error?) -> Void) {
		var request = URLRequest(url: .init(string: "https://default.corrily.com/mainapi/v1/\(endpoint)")!)
		request.httpMethod = "POST"
		request.httpBody = payload
		self.urlSession.dataTask(with: request) { data, _, error in
            completion(data, error)
		}.resume()
	}
}
