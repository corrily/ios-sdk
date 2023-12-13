//
//  File.swift
//  
//
//  Created by Thành Trang on 07/12/2023.
//

import Foundation

public struct IdentifyDto: Codable {
  var userId: String?
  var ip: String?
  var country: String?
}

public struct IdentifyResponse: Codable {
  var status: String
}
