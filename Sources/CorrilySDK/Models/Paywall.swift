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
  public var name: String
  public var interval: Interval
  public var intervalCount: Int
  public var apiId: String
  public var price: String
  public var priceUsd: String
  public var cents: Bool
  public var features: [Feature]?
  public var overrides: ProductOverrides?
  public var trial: ProductTrial?
}

public struct Feature: Codable, Identifiable {
  public var id: Int
  public var name: String
  public var valueId: Int
  public var description: String
  public var apiId: String
  public var status: String
  public var type: String
}

public struct ProductOverrides: Codable {
  public var buttonCaption: String
  public var buttonColor: String
  public var description: String
  public var badge: String
  public var cardColor: String
  public var buttonUrl: String
  public var priceIsHidden: Bool
  public var priceOverrideText: String
}

public struct ProductTrial: Codable {
  public var trialId: Int
  public var trialDays: Int
  public var trialType: String
}

public struct PricingPage: Codable {
  public var id: Int
  public var buttonsCaption: String
  public var buttonsColor: String
  public var backgroundColor: String
  public var collapseFeatures: Bool
  public var showProductDescription: Bool
  public var header: String
  public var description: String
  public var showHeader: Bool
  public var showAnnualDiscountPercentage: Bool
  public var annualDiscountPercentage: String
  public var type: String
  public var channel: String
  public var showFeatureComparisonTable: Bool
  public var featureComparisonTableText: String
  public var isDefault: Bool
  public var headerImage: String?
  public var footerDescription: String?
}

public struct PaywallResponse: Codable {
  public var success: Bool
  public var pricingPage: PricingPage
  public var products: [Product]
}

public struct PaywallDto: Codable {
  var country: String
  var userId: String?
  var ip: String?
  var paywallId: Int?
}
 
