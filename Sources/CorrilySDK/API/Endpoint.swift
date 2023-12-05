//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

struct Endpoint<Response> where Response: Codable {
  enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
  }
  
  var path: String
  
  var method: HttpMethod = .get
  var queryItems: [URLQueryItem]?
  var body: Data?
  
  
  func createURLRequest(factory: FactoryProtocol) async -> URLRequest? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = factory.config.baseUrl
    urlComponents.path = "\(path)"
    urlComponents.queryItems = queryItems
    
    guard let url = urlComponents.url else {
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
      let body = try encoder.encode(dto)
      return Endpoint(path: "/paywall", method: .post, body: body)
    } catch {
      throw error
    }
  }
}
