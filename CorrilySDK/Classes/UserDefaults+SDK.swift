//
//  UserDefaults+SDK.swift
//  CorrilySDK
//
//  Created by Andrey Filipenkov on 04.11.2023.
//  Copyright © 2023 Corrily, Inc. All rights reserved.
//

import Foundation

extension UserDefaults {

    private static let key = "CorrilySDK"

    static var sdkConfig: [String: Any] {
        standard.dictionary(forKey: key) ?? [:]
    }

    static func saveSdkConfig(_ dic: [String: Any]) {
        standard.set(dic, forKey: key)
    }
}
