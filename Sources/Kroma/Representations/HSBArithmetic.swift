import Foundation

@propertyWrapper
public struct Arithmetic<Value: BinaryFloatingPoint> {
  @Clamped(0...1) public var wrappedValue: Value = 0

  public init(wrappedValue value: Value) {
    self.wrappedValue = value
  }
}

public struct HSBArithmetic<Value: BinaryFloatingPoint>: Equatable, ColorRepresentable {
  @Arithmetic public var hue: Value = 0
  @Arithmetic public var saturation: Value = 0
  @Arithmetic public var brightness: Value = 0

  public init(
    hue: Value,
    saturation: Value,
    brightness: Value
  ) {
    self.hue = clamp(hue, with: 0...1)
    self.saturation = clamp(saturation, with: 0...1)
    self.brightness = clamp(brightness, with: 0...1)
  }

  public var representation: ColorRepresentation {
    .HSBArithmetic
  }
}

// MARK: - Equatable
extension HSBArithmetic {
  public static func == (lhs: HSBArithmetic, rhs: HSBArithmetic) -> Bool {
    lhs.hue == rhs.hue
      && lhs.saturation == rhs.saturation
      && lhs.brightness == rhs.brightness
  }
}

// MARK: - Conversions
extension HSBArithmetic where Value == Double {
  public init(_ color: RGBArithmetic<Value>) {
    let maxV = max(color.red, color.green, color.blue)
    let minV = min(color.red, color.green, color.blue)
    let delta = maxV - minV

    var hue = 0.0
    var saturation = 0.0
    var brightness = 0.0

    if delta != 0 {
      switch maxV {
      case color.red:
        hue = Value((0 + (color.green - color.blue) / delta) / 6)
      case color.green:
        hue = Value((2 + (color.blue - color.red) / delta) / 6)
      default:
        hue = Value((4 + (color.red - color.green) / delta) / 6)
      }

      if hue < 0 {
        hue += 1
      }
    }
    brightness = Value(maxV)
    saturation = brightness == 0 ? 0 : (Value(delta) / brightness)

    self.hue = hue
    self.saturation = saturation
    self.brightness = brightness
  }

  public func toRGB() -> RGBArithmetic<Value> { .init(self) }
  public func toXYZ() -> XYZComponents<Value> { toRGB().toXYZ() }
}
