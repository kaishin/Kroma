import Foundation

public struct RGBArithmetic<Value: BinaryFloatingPoint>: Equatable, ColorRepresentable {
  @Arithmetic public var red: Value = 0
  @Arithmetic public var green: Value = 0
  @Arithmetic public var blue: Value = 0

  public init(
    red: Value,
    green: Value,
    blue: Value
  ) {
    self.red = clamp(red, with: 0...1)
    self.green = clamp(green, with: 0...1)
    self.blue = clamp(blue, with: 0...1)
  }

  public var representation: ColorRepresentation {
    .RGBArithmetic
  }
}

// MARK: - Equatable
extension RGBArithmetic {
  public static func == (lhs: RGBArithmetic, rhs: RGBArithmetic) -> Bool {
    lhs.red == rhs.red
      && lhs.green == rhs.green
      && lhs.blue == rhs.blue
  }
}

// MARK: - Lightness
extension RGBArithmetic where Value == Double {
  public var luma: Double {
    return 0.2126 * red
      + 0.7152 * green
      + 0.0722 * blue
  }

  public func lighter(by value: Double = 0.1) -> Self {
    return .init(
      red: min(red + value, 1),
      green: min(green + value, 1),
      blue: min(blue + value, 1)
    )
  }

  public func darker(by value: Double = 0.1) -> Self {
    return lighter(by: -value)
  }
}

// MARK: - Conversions
extension RGBArithmetic where Value == Double {
  public init(_ color: XYZComponents<Value>) {
    func normalize(_ value: Value) -> Value {
      return (value > 0.0031308) ?
        (1.055 * pow(value, 1 / 2.4) - 0.055) :
        (12.92 * value)
    }

    let X = color.X / 100
    let Y = color.Y / 100
    let Z = color.Z / 100

    let R = normalize(X * 3.2406 + Y * -1.5372 + Z * -0.4986)
    let G = normalize(X * -0.9689 + Y * 1.8758 + Z * 0.0415)
    let B = normalize(X * 0.0557 + Y * -0.2040 + Z * 1.0570)

    self.red = R * 255
    self.green = G * 255
    self.blue = B * 255
  }

  public init(_ color: HSBArithmetic<Value>) {
    let hsb = (
      hue: color.hue,
      saturation: color.saturation,
      brightness: color.brightness
    )

    var red = 0.0
    var green = 0.0
    var blue = 0.0

    let c = hsb.brightness * hsb.saturation
    let x = c * (1 - abs((hsb.hue * 6).truncatingRemainder(dividingBy: 2) - 1))
    let m = hsb.brightness - c

    switch hsb.hue * 6 {
    case 0..<1, 6:
      red = c + m
      green = x + m
      blue = 0
    case 1..<2:
      red = x + m
      green = c + m
      blue = 0
    case 2..<3:
      red = 0
      green = c + m
      blue = x + m
    case 3..<4:
      red = 0
      green = x + m
      blue = c + m
    case 4..<5:
      red = x + m
      green = 0
      blue = c + m
    case 5..<6:
      red = c + m
      green = 0
      blue = x + m
    default:
      red = 0.0
      green = 0.0
      blue = 0.0
    }

    self.red = Value(red)
    self.green = Value(green)
    self.blue = Value(blue)
  }

  public func toHSB() -> HSBArithmetic<Value> { .init(self) }
  public func toXYZ() -> XYZComponents<Value> { .init(self) }
}
