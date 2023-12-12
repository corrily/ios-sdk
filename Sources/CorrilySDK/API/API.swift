//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

class API {
  var factory: FactoryProtocol
  
  init(factory: FactoryProtocol) {
    self.factory = factory
  }
  
  let decoder = JSONDecoder.fromSnakeCase
  
  private func request<Response: Codable>(endpoint: Endpoint<Response>) async throws -> Response {
    let urlSession = URLSession(configuration: .default)
    guard var request = await endpoint.createURLRequest(factory: factory) else {
      throw HttpError.invalidRequest
    }
    
    guard let apiKey = request.allHTTPHeaderFields?["X-Api-Key"] else {
      Logger.error("It looks like you forgot to initialize CorrilySDK. Please call `CorrilySDK.start(apiKey: String)` when launch your app!")
      throw HttpError.notAuthenticated
    }
    
    let (data, response) = try await urlSession.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw HttpError.unknown
    }
    
    switch httpResponse.statusCode {
      case 200...299: do {
        return try decoder.decode(Response.self, from: data)
      } catch {
        throw error
      }
      case -1009:
        throw HttpError.noInternet
      default: do {
        let serverError = try decoder.decode(ErrorResponse.self, from: data)
        throw HttpError.clientError(serverError)
      } catch {
        throw error
      }
    }
  }
  
  public func getPaywall(_ dto: PaywallDto) async throws -> PaywallResponse {
    return try await request(endpoint: .paywall(dto))
  }

}
