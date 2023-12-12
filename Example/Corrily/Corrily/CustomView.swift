//
//  CustomView.swift
//  Corrily
//
//  Created by Thành Trang on 12/12/2023.
//

import Foundation
import CorrilySDK
import SwiftUI

struct CustomView: View {
  let factory: FactoryProtocol
  @StateObject var paywallVM: PaywallViewModel
  
  init(factory: FactoryProtocol) {
    self.factory = factory
    _paywallVM = StateObject(wrappedValue: PaywallViewModel(factory: factory))
  }
  
  var body: some View {
    if (paywallVM.isLoading) {
      ProgressView()
    } else {
      VStack(alignment: .leading) {
        Text("Your Header")
        Text("Your Description")
        ForEach(paywallVM.paywall?.products ?? []) { product in
          HStack {
            Text(product.name)
            HStack(spacing: 0) {
              Text(product.price)
              Text("/\(product.interval == Interval.month ? "month" : "year")")
            }
          }
        }
      }
    }
  }
}
