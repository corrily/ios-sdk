//
//  File.swift
//
//
//  Created by Thành Trang on 07/12/2023.
//

import SwiftUI

public struct PaywallView: View {
  let factory: FactoryProtocol
  let paywallId: Int?
  let onSuccess: (() -> Void)?
  @StateObject var paywallVM: PaywallViewModel
  @State private var billingType: Interval = Interval.year
  @State var selectedProduct: Product? = nil
  
  init(factory: FactoryProtocol, paywallId: Int? = nil, onSuccess: (() -> Void)? = nil) {
    self.factory = factory
    self.paywallId = paywallId
    self.onSuccess = onSuccess
    _paywallVM = StateObject(wrappedValue: PaywallViewModel(paywallId: paywallId, onSuccess: onSuccess, factory: factory))
  }
  
  public var body: some View {
    if (paywallVM.isLoading) {
      PaywallViewSkeleton()
    } else {
      let pricingPage = paywallVM.paywall?.pricingPage
      
      let headerImage = pricingPage?.headerImage ?? ""
      let showHeader = pricingPage?.showHeader ?? false
      let header = pricingPage?.header ?? ""
      let showDescription = pricingPage?.showProductDescription ?? false
      let description = pricingPage?.description ?? ""
      let footerDescription = pricingPage?.footerDescription ?? ""
      let buttonsCaption = pricingPage?.buttonsCaption ?? "Continue"
      
      let callToAction = selectedProduct?.trial?.trialDays != nil ? "Start your \(selectedProduct!.trial!.trialDays)-day free trial" : buttonsCaption
      
      // Colors
      let buttonsColor = pricingPage?.buttonsColor ?? ""
      
      
      let products = billingType == Interval.month ? paywallVM.monthlyProducts : paywallVM.yearlyProducts
      
      let accentColor = buttonsColor.isEmpty ? Color.accentColor : Color(hex: buttonsColor)
      
      GeometryReader { geo in
        ScrollView {
          VStack(spacing: 24) {
            // Logo/Image
            if !headerImage.isEmpty {
              RemoteImage(url: headerImage)
                .frame(maxWidth: geo.size.width * 0.55)
            }
            
            // Header
            if (showHeader && !header.isEmpty) {
              Text(header)
                .font(Font.largeTitle.weight(.bold))
                .multilineTextAlignment(.center)
            }
            // Description
            if (showDescription && !description.isEmpty) {
              Text(description)
                .font(Font.headline.weight(.regular))
                .multilineTextAlignment(.center)
            }
            
            BillingTypeToggle(leftLabel: "Billed Monthly", rightLabel: "Billed Yearly", value: $billingType).frame(maxWidth: .infinity, alignment: .trailing)
            
            // Render Products
            ForEach(products) { product in
              let productDescription = product.overrides?.description ?? ""
              let productBadge = product.overrides?.badge ?? ""
              Button(action: {
                selectedProduct = product
              }) {
                ZStack(alignment: .topTrailing) {
                  VStack(alignment: .leading) {
                    Text(product.name).font(.headline)
                    if !productDescription.isEmpty {
                      Text(productDescription).font(.subheadline).foregroundColor(.secondary)
                    }
                    Spacer()
                    HStack {
                      VStack(alignment: .leading) {
                        ForEach(product.features ?? []) { feature in
                          Text("- \(feature.description)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                      }
                      VStack {
                        Text(product.price).font(.title2.weight(.bold))
                        Text(billingType == Interval.month ? "Billed monthly" : "Billed annually").font(.caption.weight(.bold))
                      }
                    }
                  }.frame(maxWidth: .infinity).multilineTextAlignment(.leading)
                  
                  if !productBadge.isEmpty {
                    Text(productBadge)
                      .padding([.horizontal], 16)
                      .padding([.vertical], 4)
                      .background(accentColor)
                      .foregroundColor(.white)
                      .clipShape(RoundedRectangle(cornerRadius: 7))
                      .offset(x:8, y:-8)
                  }
                }.frame(maxWidth: .infinity)
                  .padding()
                  .contentShape(Rectangle())
              }.buttonStyle(.plain).overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(selectedProduct?.id == product.id ? accentColor : Color.secondary, lineWidth: 2)
              )
            }
            
            if !footerDescription.isEmpty {
              Text(footerDescription).font(.caption).foregroundColor(.secondary)
            }
            
            if (paywallVM.errorMessage != nil && paywallVM.errorMessage!.isEmpty != true) {
              Text(paywallVM.errorMessage!).foregroundColor(.red)
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
              Text(callToAction)
                .padding(.vertical, 12)
                .font(Font.body.weight(.bold))
                .frame(maxWidth: .infinity)
                .background(accentColor)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }.buttonStyle(.plain).disabled(selectedProduct == nil)
            
            HStack {
              Button(action: {
                paywallVM.restorePurchase()
              }) {
                Text("Restore purchase")
              }
              Text("|").foregroundColor(.secondary)
              Button(action: {}) {
                Text("Terms and Conditions")
              }
            }.font(.caption).buttonStyle(.plain)
            
          }
          .frame(maxWidth: .infinity)
          .padding(16)
        }.if(pricingPage?.backgroundColor != nil) { view in
          view.background(Color(hex: pricingPage!.backgroundColor))
        }
      }
    }
  }
}
