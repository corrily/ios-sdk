//
//  ApiResponse.swift
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

//struct Paywall {
//    struct Request: Encodable {
//        let apiID: String
//        let userID: String
//        let country: String
//        let dev: Bool
//        let experimentID: Int?
//    }
//
//    struct Response: Decodable {
//        let success: Bool
//        let products: [Product]
//
//        struct Product: Decodable {
//            let id: Int
//            let name: String
//            let interval: Interval
//            let intervalCount: Int
//            let apiId: String
//            let price: String
//            let priceUsd: String
//
//            enum Interval: String, Decodable {
//                case month
//                case year
//            }
//        }
//    }
//}
//
///// Object representing Corrilly product
//public struct PaywallProduct {
//    /// Product ID in AppStoreConnect
//    public let appStoreConnectID: String
//    /// Product ID in Corrily dashboard
//    public let corrilyID: Int
//    /// Product name in Corrily dashboard
//    public let name: String
//    /// Duration of this product, for example `2` in a monthly product means 2 months
//    public let intervalCount: Int
//    /// Product price with currency symbol according to the provided country
//    public let price: String
//    /// Product price with currency symbol in USD
//    public let priceUSD: String
//}
//
//struct ChargeRequest: Encodable {
//    let amount: Double
//    let created: Date
//    let currency: String
//    let country: String
//    let origin: String
//    let originID: String
//    let product: String
//    let status: String
//    let userID: String
//}
