//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

enum Interval: String, Codable {
  case month
  case year
}

struct Product: Codable {
  var id: Int
  var name: String
  var interval: Interval
  var apiId: String
  var price: String
  var priceUsd: String
}

struct PaywallResponse: Codable {
  var success: Bool
  var products: [Product]
}

struct PaywallDto: Codable {
  var apiId: String
  var userId: String
  var country: String
  var dev: Bool
  var experimentId: Int?
}
 
