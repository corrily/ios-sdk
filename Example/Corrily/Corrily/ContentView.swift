//
//  ContentView.swift
//  Corrily
//
//  Created by Thành Trang on 11/12/2023.
//

import SwiftUI
import CorrilySDK

struct ContentView: View {
  @State private var showPaywall = false
  @State private var showPaywallCustomView = false
  
  var body: some View {
    
        VStack(spacing: 24) {
          Button(action: {
            showPaywall = true
          }, label: {
            Text("Show Paywall")
          })
          .sheet(isPresented: $showPaywall) {
            CorrilySDK.renderPaywall(action: {
              showPaywall = false
            })
          }
          Button(action: {
            showPaywallCustomView = true
          }, label: {
            Text("Show Paywall with custom view")
          })
          .sheet(isPresented: $showPaywallCustomView) {
            CorrilySDK.renderPaywall(customView: { factory in
              CustomView(factory: factory, onSuccess: {
                showPaywallCustomView = false
              })
            })
          }
        }
        .padding()
  }
}

#Preview {
  ContentView()
}
