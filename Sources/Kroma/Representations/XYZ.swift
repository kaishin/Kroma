import Foundation

private let XYZReference = (X: 95.047, Y: 100.000, Z: 108.883)

public struct XYZComponents<Value: BinaryFloatingPoint> {
  @Clamped(0...Value(XYZReference.X)) public var X: Value = 0
  @Clamped(0...Value(XYZReference.Y)) public var Y: Value = 0
  @Clamped(0...Value(XYZReference.Z)) public var Z: Value = 0

  public init(
    X: Value,
    Y: Value,
    Z: Value
  ) {
    self.X = clamp(X, with: 0...Value(XYZReference.X))
    self.Y = clamp(Y, with: 0...Value(XYZReference.Y))
    self.Z = clamp(Z, with: 0...Value(XYZReference.Z))
  }
}

// MARK: - Equatable
extension XYZComponents {
  public static func == (lhs: XYZComponents, rhs: XYZComponents) -> Bool {
    lhs.X == rhs.X
      && lhs.Y == rhs.Y
      && lhs.Z == rhs.Z
  }
}

// MARK: - Conversions
extension XYZComponents where Value == Double {
  public init(_ color: RGBArithmetic<Value>)  {
    func normalize(_ value: Double) -> Double {
      return (value > 0.04045) ? pow((value + 0.055) / 1.055, 2.4) : (value / 12.92)
    }

    let R = normalize(Double(color.red / 255)) * 100
    let G = normalize(Double(color.green / 255)) * 100
    let B = normalize(Double(color.blue / 255)) * 100

    self.X = R * 0.4124 + G * 0.3576 + B * 0.1805
    self.Y = R * 0.2126 + G * 0.7152 + B * 0.0722
    self.Z = R * 0.0193 + G * 0.1192 + B * 0.9505
  }

  public func toRGB() -> RGBArithmetic<Value> { .init(self) }
  public func toHSB() -> HSBArithmetic<Value> { toRGB().toHSB() }
}
