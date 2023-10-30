//
//  CorillyAPI.swift
//  CorrilySDK
//
//  Created by Andrey Filipenkov on 30.10.2023.
//  Copyright © 2023 Corrily, Inc. All rights reserved.
//

import Foundation

class CorillyAPI {

	static let shared = CorillyAPI()
	private init() {}

	private let urlSession = URLSession(configuration: {
		var config = URLSessionConfiguration.default
		config.httpAdditionalHeaders = [
			"Content-Type": "application/json",
		]
		return config
	}())

	func call(endpoint: String, payload: Data, completion: @escaping (Data?) -> Void) {
		var request = URLRequest(url: .init(string: "https://default.corrily.com/mainapi/v1/\(endpoint)")!)
		request.httpMethod = "POST"
		request.httpBody = payload
		self.urlSession.dataTask(with: request) { data, _, error in
			defer {
				completion(data)
			}

			guard let data = data else {
				print("request error:", error)
				return
			}
			print("raw response:", String(data: data, encoding: .utf8))
		}.resume()
	}
}
