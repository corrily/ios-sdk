//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

extension Date {
  static let isoFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    return formatter
  }()

  var isoString: String {
    return Self.isoFormatter.string(from: self)
  }
  
  var timestamp: Int {
    return Int(Self().timeIntervalSince1970)
  }
}
