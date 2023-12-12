//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

extension JSONEncoder {
  static let toSnakeCase: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return encoder
  }()
}

extension JSONDecoder {
  static let fromSnakeCase: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
}
