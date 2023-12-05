//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

enum HttpError: LocalizedError {
  case invalidRequest
  case unknown
  case notAuthenticated
  case decoding
  case notFound
  case invalidUrl
  case invalidData
  case noInternet

  var description: String? {
    switch self {
    case .invalidRequest: return NSLocalizedString("Request invalid", comment: "")
    case .unknown: return NSLocalizedString("An unknown error occurred.", comment: "")
    case .notAuthenticated: return NSLocalizedString("Unauthorized.", comment: "")
    case .decoding: return NSLocalizedString("Decoding error.", comment: "")
    case .notFound: return NSLocalizedString("Not found", comment: "")
    case .invalidUrl: return NSLocalizedString("URL invalid", comment: "")
    case .invalidData: return NSLocalizedString("Data invalid", comment: "")
    case .noInternet: return NSLocalizedString("No Internet", comment: "")
    }
  }
}
