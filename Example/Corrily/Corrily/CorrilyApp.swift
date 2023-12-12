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
    CorrilySDK.start(apiKey: "a147424f-98f1-4ee0-aa88-16f83f8dc683")
    CorrilySDK.setUser(userId: "test_1234501", country: "US")
  }
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
