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
    CorrilySDK.start(apiKey: "")
  }
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
