//
//  File.swift
//  
//
//  Created by Thành Trang on 05/12/2023.
//

import Foundation

public protocol FactoryProtocol: AnyObject {
  var config: ConfigManager! { get }
  var storage: StorageManager! { get }
  var user: UserManager! { get }
}
