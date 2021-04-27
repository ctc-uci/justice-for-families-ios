//
//  Time.swift
//  justice-for-families
//
//  Created by Ethan  Nguyen on 4/26/21.
//

import Swift
import Foundation

extension Date {
  func timeAgoDisplay() -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    return formatter.localizedString(for: self, relativeTo: Date())
  }
}
