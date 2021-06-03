//
//  NSMutableData+Extensions.swift
//  eTurist
//
//  Created by Marko on 03.06.2021..
//

import Foundation

extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
