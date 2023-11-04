//
//  UserID.swift
//  CorrilySDK
//
//  Created by Andrey Filipenkov on 04.11.2023.
//  Copyright © 2023 Corrily, Inc. All rights reserved.
//

import AdSupport
import AppTrackingTransparency
import Foundation

struct UserID {

    static var userID: String {
        idfa ?? uuid
    }

    private static var idfa: String? {
        let shouldReturnIDFA: Bool
        if #available(iOS 14, tvOS 14, *) {
            if ProcessInfo.processInfo.isOperatingSystemAtLeast(.init(majorVersion: 14, minorVersion: 5, patchVersion: 0)) {
                shouldReturnIDFA = ATTrackingManager.trackingAuthorizationStatus == .authorized
            } else {
#if targetEnvironment(simulator)
                shouldReturnIDFA = false
#else
                shouldReturnIDFA = true
#endif
            }
        } else {
            shouldReturnIDFA = ASIdentifierManager.shared().isAdvertisingTrackingEnabled
        }
        return shouldReturnIDFA ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : nil
    }

    private static var uuid: String {
        let uuidKey = "uuid"

        var config = UserDefaults.sdkConfig
        if let uuid = config[uuidKey] as? String {
            return uuid
        }

        let uuid = UUID().uuidString
        config[uuidKey] = uuid
        UserDefaults.saveSdkConfig(config)
        return uuid
    }
}
