//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

public struct Endpoint<Response> where Response: Codable {
  enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
  }
  
  var path: String
  
  var method: HttpMethod = .get
  var queryItems: [URLQueryItem]?
  var body: Data?
  
  
  func createURLRequest(factory: FactoryProtocol) async -> URLRequest? {
    guard let url = URL(string: "\(factory.config.channel.baseUrl)\(path)") else {
      return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    if let httpBody = body {
      request.httpBody = httpBody
    }
    
    let headers: [String: String] = [
      "X-Api-Key": factory.config.apiKey,
      "Content-Type": "application/json"
    ]
    for header in headers {
      request.setValue(header.value, forHTTPHeaderField: header.key)
    }
    
    return request
  }
}

extension Endpoint where Response == PaywallResponse {
  static func paywall(_ dto: PaywallDto) throws -> Self {
    let encoder = JSONEncoder.toSnakeCase
    do {
      Logger.info("API request: POST /v1/paywall")
      let body = try encoder.encode(dto)
      return Endpoint(path: "/v1/paywall", method: .post, body: body)
    } catch {
      Logger.error("API request: POST /v1/paywall failed!")
      throw error
    }
  }
}

extension Endpoint where Response == IdentifyResponse {
  static func identify(_ dto: IdentifyDto) throws -> Self {
    let encoder = JSONEncoder.toSnakeCase
    do {
      Logger.info("API request: POST /v1/identify")
      let body = try encoder.encode(dto)
      return Endpoint(path: "/v1/identify", method: .post, body: body)
    } catch {
      Logger.error("API request: POST /v1/identify failed!")
      throw error
    }
  }
}
