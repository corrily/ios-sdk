//
//  File.swift
//  
//
//  Created by Thành Trang on 15/12/2023.
//

import Foundation
import SwiftUI

struct BillingTypeToggle: View {
  let leftLabel: String
  let rightLabel: String
  @State var color: Color = Color.blue
  
  @Binding var value: Interval
  var body: some View {
    Button(action: {
      withAnimation(.easeInOut(duration: 0.2)) {
        value = value == Interval.month ? Interval.year : Interval.month
      }
    }) {
      HStack {
        Text(leftLabel).foregroundColor(value == Interval.month ? Color.primary : Color.gray).font(.caption)
        Toggle("", isOn: Binding(get: {
          self.value == Interval.year
        }, set: {
          newValue in self.value = newValue ? Interval.year : Interval.month
        }))
          .labelsHidden()
          .toggleStyle(BillingToggleStyle(color: color))
        Text(rightLabel).foregroundColor(value == Interval.year ? Color.primary : Color.gray).font(.caption)
      }
    }.buttonStyle(PlainButtonStyle())
  }
}

struct BillingToggleStyle: ToggleStyle {
  let color: Color
  let thumbColor: Color = Color.white
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      RoundedRectangle(cornerRadius: 16)
        .fill(color)
        .frame(width: 31, height: 18)
        .overlay(Circle()
          .fill(thumbColor)
          .shadow(radius: 1, x: 0, y: 1)
          .padding(2)
          .offset(x: configuration.isOn ? 6 : -6))
        .onTapGesture {
          withAnimation(.easeInOut(duration: 0.2)) {
            configuration.isOn.toggle()
          }
        }
    }
  }
}
