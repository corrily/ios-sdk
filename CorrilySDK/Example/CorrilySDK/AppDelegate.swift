//
//  AppDelegate.swift
//  CorrilySDK
//
//  Created by Andrey Filipenkov on 29.10.2023.
//  Copyright © 2023 Corrily, Inc. All rights reserved.
//

import UIKit
import CorrilySDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CorrilySDK.start(apiKey: "")
        return true
    }
}
