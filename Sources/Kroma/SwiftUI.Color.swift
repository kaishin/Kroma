import SwiftUI

#if canImport(UIKit)
import UIKit
typealias PlatformColor = UIColor
#elseif canImport(AppKit)
import AppKit
typealias PlatformColor = NSColor
#endif

extension Color {
  public var raw: CGColor {
    cgColor ?? PlatformColor(self).cgColor
  }
}

// MARK: - RGB
extension Color {
  public var rgbComponents: RGBArithmetic<Double> {
    let components: [CGFloat] = {
      guard let rawComponents = raw.components else {
        return []
      }

      if rawComponents.count == 4 {
        return Array(rawComponents[0...2])
      } else if rawComponents.count == 2 {
        return Array(repeating: rawComponents[0], count: 3)
      } else {
        return []
      }
    }()

    guard components.count == 3 else { return .init(red: 0, green: 0, blue: 0) }

    return .init(
      red: Double(components[0]),
      green: Double(components[1]),
      blue: Double(components[2])
    )
  }

  public init(_ rgb: RGBArithmetic<Double>, space: RGBColorSpace = .sRGB) {
    self.init(
      space,
      red: rgb.red,
      green: rgb.green,
      blue: rgb.blue,
      opacity: 1.0
    )
  }
}

// MARK: - Lightness
extension Color {
  public func lighter(by value: Double = 0.1) -> Self {
    let rgb = rgbComponents.lighter(by: value)

    return .init(
      red: min(rgb.red + value, 1),
      green: min(rgb.green + value, 1),
      blue: min(rgb.blue + value, 1)
    )
  }

  public func darker(by value: Double = 0.1) -> Self {
    lighter(by: -value)
  }

  public var luma: Double {
    rgbComponents.luma
  }

  // More info: https://thoughtbot.com/blog/closer-look-color-lightness
  public var isLight: Bool {
    return luma >= 0.5
  }
}
