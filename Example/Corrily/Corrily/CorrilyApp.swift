//
//  CorrilyApp.swift
//  Corrily
//
//  Created by Thành Trang on 11/12/2023.
//

import SwiftUI
import CorrilySDK

@main
struct CorrilyApp: App {
  init() {
    CorrilySDK.start(apiKey: "538b7425-f86d-4c6d-a186-7ac39d297c3d")
    CorrilySDK.setUser(userId: "test_1234501", country: "US")
  }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
