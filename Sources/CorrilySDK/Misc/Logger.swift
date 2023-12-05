//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

public struct Logger {
  private init() {}
  enum LogLevel {
    case info
    case warn
    case error
    var prefix: String {
      switch self {
      case .info: return "[Info 💬]"
      case .warn: return "[Warning ⚠️]"
      case .error: return "[Error ⁉️]"
      }
    }
  }
  
  struct Context {
    let file: String
    let function: String
    let line: Int
    let trace: Any?
    var description: String {
      return "[\((file as NSString).lastPathComponent)]:\(line) in \(function)"
    }
  }
  
  private static func log(level: LogLevel, message: String, context: Context?) {
    #if DEBUG
    print("\(Date().isoString) \(level.prefix) \(message)")
    if let context = context {
      print(" → \(context.description)")
      if let trace = context.trace {
        dump(trace)
      }
    }
    #endif
  }
  
  public static func info(_ message: String, trace: Any? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    let context = Context(file: file, function: function, line: line, trace: trace)
    Logger.log(level: .info, message: message, context: context)
  }
  public static func warn(_ message: String, trace: Any? = nil, file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
    let context = Context(file: file, function: function, line: line, trace: trace)
    Logger.log(level: .warn, message: message, context: context)
  }
  public static func error(_ message: String, trace: Any? = nil, file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
    let context = Context(file: file, function: function, line: line, trace: trace)
    Logger.log(level: .error, message: message, context: context)
  }
}
