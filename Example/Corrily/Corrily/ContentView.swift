//
//  ContentView.swift
//  Corrily
//
//  Created by Thành Trang on 11/12/2023.
//

import SwiftUI
import CorrilySDK

struct ContentView: View {
  
  var body: some View {
    TabView {
      DefaultTemplateView().tabItem {
        Image(systemName: "globe")
        Text("Default Template")
      }
      CustomTemplateView().tabItem {
        Image(systemName: "creditcard")
        Text("Custom Template")
      }
    }
  }
}

#Preview {
  ContentView()
}

struct DefaultTemplateView: View {
  var body: some View {
    CorrilySDK.renderPaywall()
  }
}

struct CustomTemplateView: View {
  var body: some View {
    CorrilySDK.renderPaywall(customView: { factory in
      CustomView(factory: factory)
    })
  }
}
