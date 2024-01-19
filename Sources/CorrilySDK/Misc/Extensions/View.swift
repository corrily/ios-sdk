//
//  File.swift
//
//
//  Created by Thành Trang on 19/01/2024.
//

import Foundation
import SwiftUI

extension View {
  @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
    if condition() {
      transform(self)
    } else {
      self
    }
  }
}

