//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

public enum Interval: String, Codable {
  case month
  case year
}

public struct Product: Codable, Identifiable {
  public var id: Int
  var name: String
  var interval: Interval
  var intervalCount: Int
  var apiId: String
  var price: String
  var priceUsd: String
  var cents: Bool
  var features: [Feature]?
}

public struct Feature: Codable, Identifiable {
  public var id: Int
  var name: String
  var valueId: Int
  var description: String
  var apiId: String
  var status: String
  var type: String
}

public struct PricingPage: Codable {
  public var id: Int
  var buttonsCaption: String
  var buttonsColor: String
  var backgroundColor: String
  var collapseFeatures: Bool
  var showProductDescription: Bool
  var header: String
  var description: String
  var showHeader: Bool
  var showAnnualDiscountPercentage: Bool
  var annualDiscountPercentage: String
  var type: String
  var channel: String
  var showFeatureComparisonTable: Bool
  var featureComparisonTableText: String
  var isDefault: Bool
  
}

public struct PaywallResponse: Codable {
  var success: Bool
  var pricingPage: PricingPage
  var products: [Product]
}

public struct PaywallDto: Codable {
  var userId: String?
  var country: String
  var ip: String?
  var paywallId: Int?
}
 
