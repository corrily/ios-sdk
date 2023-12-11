//
//  ContentView.swift
//  Corrily
//
//  Created by Thành Trang on 11/12/2023.
//

import SwiftUI
import CorrilySDK

struct ContentView: View {
  @State private var isPresented = false
  var body: some View {
    VStack {
      Button(action: {
        isPresented = true
      }, label: {
        Text("Show Paywall")
      })
      .sheet(isPresented: $isPresented) {
        CorrilySDK.renderPaywall()
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
