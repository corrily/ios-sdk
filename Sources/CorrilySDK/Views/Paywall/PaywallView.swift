//
//  File.swift
//
//
//  Created by Thành Trang on 07/12/2023.
//

import SwiftUI

public struct PaywallView: View {
  let factory: FactoryProtocol
  let onSuccess: (() -> Void)?
  @StateObject var paywallVM: PaywallViewModel
  @State private var billingType: Interval = Interval.year
  @State var selectedProduct: Product? = nil
  
  init(factory: FactoryProtocol, onSuccess: (() -> Void)? = nil) {
    self.factory = factory
    self.onSuccess = onSuccess
    _paywallVM = StateObject(wrappedValue: PaywallViewModel(factory: factory))
  }
  
  public var body: some View {
    if (paywallVM.isLoading) {
      PaywallViewSkeleton()
    } else {
      let pricingPage = paywallVM.paywall?.pricingPage
      let (
        headerImage,
        showHeader,
        header,
        showDescription,
        description,
        footerDescription
      ) = (
        pricingPage?.headerImage,
        pricingPage?.showHeader ?? false,
        pricingPage?.header ?? "Get Your Creative Juices Flowing",
        pricingPage?.showProductDescription ?? false,
        pricingPage?.description ?? "Select a plan that fits your need. Free 7-day trial",
        pricingPage?.footerDescription
      )
      
      let products = billingType == Interval.month ? paywallVM.monthlyProducts : paywallVM.yearlyProducts
      
      let (
        backgroundColor,
        buttonsColor,
        buttonsTextColor
      ) = (
        pricingPage?.backgroundColor ?? "#ffffff",
        pricingPage?.buttonsColor ?? "#ffff00",
        "#ffffff"
      )
      
      GeometryReader { geo in
        ScrollView {
          VStack(spacing: 24) {
            // Logo/Image
            if (headerImage != nil && headerImage!.isEmpty != true) {
              RemoteImage(url: headerImage!)
                .frame(maxWidth: geo.size.width * 0.55)
            }
            
            // Header
            if (showHeader) {
              Text(header)
                .font(Font.largeTitle.weight(.bold))
                .multilineTextAlignment(.center)
            }
            // Description
            if (showDescription) {
              Text(description)
                .font(Font.headline.weight(.regular))
                .multilineTextAlignment(.center)
            }

            BillingTypeToggle(leftLabel: "Billed Monthly", rightLabel: "Billed Yearly", value: $billingType).frame(maxWidth: .infinity, alignment: .trailing)
            
            // Render Products
            ForEach(products) { product in
              Button(action: {
                selectedProduct = product
              }) {
                ZStack(alignment: .topTrailing) {
                  VStack(alignment: .leading) {
                    Text(product.name)
                      .font(.headline)
                      .multilineTextAlignment(.leading)
                    if (product.overrides?.description != nil && product.overrides?.description.isEmpty != true) {
                      Text(product.overrides!.description).font(.subheadline).multilineTextAlignment(.leading)
                    }
                    HStack {
                      VStack(alignment: .leading) {
                        ForEach(product.features ?? []) { feature in
                          Text("- \(feature.description)")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                      }
                      .frame(maxWidth: .infinity)
                      VStack(spacing: 4) {
                        Text(product.price)
                          .font(.title2).fontWeight(.bold)
                        Text(billingType == Interval.month ? "Billed monthly" : "Billed annually")
                          .font(.caption).fontWeight(.bold)
                      }
                    }.frame(maxWidth: .infinity)
                  }
                  .padding()
                  .frame(maxWidth: .infinity)
                  .overlay(
                    RoundedRectangle(cornerRadius: 10)
                      .stroke(selectedProduct?.id == product.id ? Color(hex: buttonsColor) : Color(hex: "#eeeeee"), lineWidth: 2)
                  )
                  
                  if (product.overrides?.badge != nil && product.overrides?.badge.isEmpty != true) {
                    Text(product.overrides!.badge)
                      .padding([.horizontal], 16)
                      .padding([.vertical], 4)
                      .background(Color(hex: buttonsColor))
                      .foregroundColor(Color(hex: buttonsTextColor))
                      .clipShape(RoundedRectangle(cornerRadius: 7))
                      .offset(x:-4, y:4)
                  }
                }
              }.buttonStyle(PlainButtonStyle())
            }
            if (paywallVM.errorMessage != nil && paywallVM.errorMessage!.isEmpty != true) {
              Text(paywallVM.errorMessage!).foregroundColor(Color.red)
            }
            Button(action: {
              if (selectedProduct != nil ) {
                Logger.info("Selected product with productId: \(selectedProduct!.id) and apiId \(selectedProduct!.apiId)")
                paywallVM.purchase(product: selectedProduct!)
                if (onSuccess != nil) {
                  onSuccess!()
                }
              }
            }) {
              Text(selectedProduct?.trial?.trialDays != nil ? "Start your \(selectedProduct!.trial!.trialDays)-day free trial" : "Continue")
                .padding(.vertical, 16)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity)
                .background(Color(hex: buttonsColor))
                .foregroundColor(Color(hex: buttonsTextColor))
                .font(Font.body.weight(.bold))
                .clipShape(
                  RoundedRectangle(cornerRadius: 10)
                )
            }.disabled(selectedProduct == nil)
            HStack {
              Button(action: {}) {
                Text("Restore purchase").foregroundColor(Color(hex: "#000000")).font(.caption)
              }
              Text("|").foregroundColor(Color(hex: "#999999")).font(.caption)
              Button(action: {}) {
                Text("Terms and Conditions").foregroundColor(Color(hex: "#000000")).font(.caption)
              }
            }
          }
          .frame(maxWidth: .infinity)
          .padding(16)
        }.background(Color(hex: backgroundColor))
        
      }
    }
  }
}
