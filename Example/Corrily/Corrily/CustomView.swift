//
//  CustomView.swift
//  Corrily
//
//  Created by Thành Trang on 12/12/2023.
//

import Foundation
import CorrilySDK
import SwiftUI

struct Feature: Identifiable {
  public var id: String
  public var name: String
}



struct CustomView: View {
  let factory: FactoryProtocol
  let onSuccess: (() -> Void)
  @StateObject var paywallVM: PaywallViewModel
  @State var selectedProduct: Product? = nil
  
  let features: [Feature] = [
    Feature(id: "feat-1", name: "Join our 20,000+ member community"),
    Feature(id: "feat-2", name: "Organize group hikes"),
    Feature(id: "feat-3", name: "Share photos and tips of your trips"),
    Feature(id: "feat-4", name: "Connect with locals and find neaby trails")
  ]
  
  init(factory: FactoryProtocol, onSuccess: @escaping (() -> Void)) {
    self.factory = factory
    self.onSuccess = onSuccess
    _paywallVM = StateObject(wrappedValue: PaywallViewModel(factory: factory))
  }
  
  var body: some View {
    if (paywallVM.isLoading) {
      ProgressView()
    } else {
      let (
        products
      ) = (
        paywallVM.yearlyProducts
      )
      GeometryReader { geo in
        ScrollView {
          VStack(alignment: .leading, spacing: 0) {
            Image("hero").resizable().frame(maxWidth: .infinity)
            VStack(alignment: .leading, spacing: 16) {
              Text("Unlock adventure,\nexplore the outdoor,\nbuild your community").font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
              VStack(alignment: .leading, spacing: 4) {
                ForEach(features) {feature in
                  HStack {
                    Image("check")
                    Text(feature.name).font(.body)
                  }
                }
              }
              VStack(alignment: .leading) {
                ForEach(products) { product in
                  let isSelected = selectedProduct?.id == product.id
                  let overrides = product.overrides
                  let trialDays = product.trial?.trialDays ?? 0
                  Button(action: {
                    selectedProduct = product
                  }) {
                    ZStack(alignment: .topTrailing) {
                      VStack(alignment: .leading, spacing: 8) {
                        HStack {
                          ZStack {
                            Circle().fill(isSelected ? Color.yellow : Color.gray.opacity(0.6)).frame(width: 16, height: 16)
                            if (isSelected == true) {
                              Image("check").resizable().frame(width: 14, height: 14)
                            }
                          }
                          Text(product.name).font(.headline)
                          Spacer()
                        }
                        
                        Text(trialDays > 0 ? "Free for \(trialDays) days, then \(product.price)/year" : "\(product.price)/year").font(.subheadline)
                      }.frame(maxWidth: .infinity).padding().overlay(
                        RoundedRectangle(cornerRadius: 10)
                          .stroke(isSelected ? Color.yellow : Color.gray.opacity(0.6), lineWidth: 2)
                      )
                      if (overrides?.badge != nil && overrides!.badge.isEmpty != true) {
                        Text(overrides!.badge)
                          .padding([.horizontal], 16)
                          .padding([.vertical], 4)
                          .background(Color.yellow)
                          .foregroundStyle(Color.white)
                          .clipShape(RoundedRectangle(cornerRadius: 8))
                          .offset(x: -4, y: 4)
                      }
                    }
                  }.buttonStyle(PlainButtonStyle())
                }
              }
              Button(action: {
                paywallVM.purchase(product: selectedProduct!)
                onSuccess()
              }) {
                Text("Start your Free trial")
                  .font(.title3)
                  .frame(maxWidth: .infinity)
                  .padding([.vertical], 14)
                  .background(Color.blue)
                  .foregroundStyle(Color.white)
                  .clipShape(RoundedRectangle(cornerRadius: 8))
              }.buttonStyle(PlainButtonStyle()).disabled(selectedProduct == nil)
              HStack(spacing: 4) {
                Button(action: {}) {
                  Text("Restore Purchase")
                }
                Text("⋅")
                Button(action: {}) {
                  Text("Terms and Conditions")
                }
              }.font(.caption).frame(maxWidth: .infinity)
            }.padding(16)
          }
        }
      }.edgesIgnoringSafeArea([.top,.bottom])
    }
  }
}
