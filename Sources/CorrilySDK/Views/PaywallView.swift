//
//  File.swift
//
//
//  Created by Thành Trang on 07/12/2023.
//

import SwiftUI

public struct PaywallView: View {
  let factory: FactoryProtocol
  @StateObject var paywallVM: PaywallViewModel
  @State var billingType: Interval = Interval.month
  
  init(factory: FactoryProtocol) {
    self.factory = factory
    _paywallVM = StateObject(wrappedValue: PaywallViewModel(factory: factory))
  }
  
  public var body: some View {
    if (paywallVM.isLoading) {
      PaywallViewSkeleton()
    } else {
      let (
        showHeader,
        header,
        showDescription,
        description
      ) = (
        paywallVM.paywall?.pricingPage.showHeader ?? false,
        paywallVM.paywall?.pricingPage.header ?? "Get Your Creative Juices Flowing",
        paywallVM.paywall?.pricingPage.showProductDescription ?? false,
        paywallVM.paywall?.pricingPage.description ?? "Select a plan that fits your need. Free 7-day trial"
      )
      
      let products = billingType == Interval.month ? paywallVM.monthlyProducts : paywallVM.yearlyProducts
      
      let (
        backgroundColor,
        buttonsColor,
        buttonsTextColor
      ) = (
        paywallVM.paywall?.pricingPage.backgroundColor ?? "#ffffff",
        paywallVM.paywall?.pricingPage.buttonsColor ?? "#ffff00",
        "#ffffff"
      )
      VStack {
        ScrollView {
          VStack(spacing: 24) {
            // Logo/Image
            RemoteImage(url: "https://placehold.co/300x100/png").frame(width: 300, height: 100)
            // Header
            if (showHeader) {
              Text("Get Your Creative Juices Flowing")
                .font(Font.largeTitle.weight(.bold))
                .multilineTextAlignment(.center)
            }
            // Description
            if (showDescription) {
              Text("Select a plan that fits your need. Free 7-day trial")
                .font(Font.headline.weight(.regular))
                .multilineTextAlignment(.center)
            }
            Toggle(isOn: Binding(get: {
              self.billingType == Interval.month
            }, set: {
              newValue in self.billingType = newValue ? Interval.month : Interval.year
            }), label: {
              Text("Monthly bill")
            })
            // Render Products
            ForEach(products) { product in
              ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading) {
                  Text(product.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                  HStack {
                    VStack(alignment: .leading) {
                      ForEach(product.features ?? []) { feature in
                        Text("- \(feature.description)")
                          .font(.caption)
                          .frame(maxWidth: .infinity, alignment: .leading)
                      }
                    }
                    .frame(maxWidth: .infinity)
                    VStack(spacing: 12) {
                      Text(product.price)
                        .font(.title2).fontWeight(.bold)
                      Text("$96 billed annually")
                        .font(.caption).fontWeight(.bold)
                    }
                  }.frame(maxWidth: .infinity)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple) // Set the background color to purple
                .foregroundColor(.white) // Set the text color to white
                .clipShape(
                  RoundedRectangle(cornerRadius: 20)
                )
                .onTapGesture {
                  print("Selected product \(product.name)")
                }
                
                Text("Recommended")
                  .padding([.horizontal], 16)
                  .padding([.vertical], 4)
                  .background(Color.yellow)
                  .clipShape(RoundedRectangle(cornerRadius: 7))
                  .offset(x:0, y:-16)
              }
            }
            // Footer
            Text("Product features can change anytime. Payment will be chaged to your App Store account. Subscription will auto-renew at the selected interval. You can cancel the subscription at any time. By clicking, Subscribe, you agree to the [Subscription Terms](https://google.com).").font(.caption)
          }
          .frame(maxWidth: .infinity)
          .padding(16)
        }
        
        Button(action: {}) {
          Text("Start your 7-day free trial")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(hex: buttonsColor))
            .foregroundColor(Color(hex: buttonsTextColor))
            .font(Font.title.weight(.bold))
        }
      }.background(Color(hex: backgroundColor)).edgesIgnoringSafeArea(.bottom)
    }
  }
}
