//
//  FallbackPaywallView.swift
//  Corrily
//
//  Created by Thành Trang on 14/12/2023.
//

import Foundation
import SwiftUI
import CorrilySDK

struct FallbackPaywallView: View {
  let fallbackPaywall = """
{"pricing_page":{"id":132,"buttons_caption":"Select Plan","buttons_color":"#2c77e7","background_color":"#ffffff","collapse_features":false,"show_product_description":false,"header":"Header from fallback","description":"","show_header":true,"features_badges":{},"show_annual_discount_percentage":false,"annual_discount_percentage":"","type":"pricing_page","channel":"web","show_feature_comparison_table":true,"feature_comparison_table_text":"Compare All Plans","is_default":true,"header_image":null,"footer_description":null,"show_web_features":false,"show_mobile_features":false},"products":[{"id":38162,"name":"Advanced Annual","features":[{"id":9583,"name":"Basic Weather Metrics","value":null,"value_id":13505,"unit":null,"description":"Basic Weather Metrics","api_id":"test_feature","status":"active","type":"boolean","feature_group":null},{"id":10061,"name":"Advanced Features","value":null,"value_id":14187,"unit":null,"description":"Advanced Features","api_id":"advanced_features","status":"active","type":"boolean","feature_group":null}],"interval":"year","interval_count":1,"api_id":"magicweather.advanced.annual","cents":false,"recurrent_horizon":"","group":null,"price":"$12.99","price_usd":"$13","trial":null,"product_metadata":{"description":""},"overrides":null},{"id":38163,"name":"Advanced Monthly","features":[{"id":10061,"name":"Advanced Features","value":null,"value_id":14187,"unit":null,"description":"Advanced Features","api_id":"advanced_features","status":"active","type":"boolean","feature_group":null},{"id":9583,"name":"Basic Weather Metrics","value":null,"value_id":13505,"unit":null,"description":"Basic Weather Metrics","api_id":"test_feature","status":"active","type":"boolean","feature_group":null}],"interval":"month","interval_count":1,"api_id":"magicweather.advanced.monthly","cents":false,"recurrent_horizon":"","group":null,"price":"$3.99","price_usd":"$4","trial":null,"product_metadata":{"description":""},"overrides":null},{"id":38164,"name":"Basic Annual","features":[{"id":9583,"name":"Basic Weather Metrics","value":null,"value_id":13505,"unit":null,"description":"Basic Weather Metrics","api_id":"test_feature","status":"active","type":"boolean","feature_group":null}],"interval":"year","interval_count":1,"api_id":"magicweather.basic.annual","cents":false,"recurrent_horizon":"","group":null,"price":"$9.99","price_usd":"$10","trial":null,"product_metadata":{"description":""},"overrides":null},{"id":38165,"name":"Basic Monthly","features":[{"id":9583,"name":"Basic Weather Metrics","value":null,"value_id":13505,"unit":null,"description":"Basic Weather Metrics","api_id":"test_feature","status":"active","type":"boolean","feature_group":null}],"interval":"month","interval_count":1,"api_id":"magicweather.basic.monthly","cents":false,"recurrent_horizon":"","group":null,"price":"$1.99","price_usd":"$2","trial":null,"product_metadata":{"description":""},"overrides":null}],"success":true,"prices_raw_response":null,"trace_id":null}
"""
  init() {
    CorrilySDK.setFallbackPaywall(fallbackPaywall)
  }
  var body: some View {
    CorrilySDK.renderPaywall()
  }
}
