//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {
  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
     try await withCheckedThrowingContinuation { continuation in
       let task = self.dataTask(with: request, completionHandler: { data, response, error in
         guard let data = data, let response = response else {
           let error = error ?? URLError(.badServerResponse)
           return continuation.resume(throwing: error)
         }
         continuation.resume(returning: (data, response))
       })
       task.resume()
    }
  }
}

