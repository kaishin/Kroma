
public enum ColorRepresentation {
  case RGBArithmetic // (0.0, 1.0, 0.0)
  case RGBPercentage // (0%, 100%, 0%)
  case RGB8BitNumeric // (0, 255, 0)
  case RGB8BitHexadecimal // #00FF00
  case HSL // (120˚, 100%, 50%)
  case HSLArithmetic // (0.0, 1.0, 0.0)
  case HSB // (120˚, 100%, 100%)
  case HSBArithmetic // (0.0, 1.0, 0.0)
  case HSV // (120˚, 100%, 100%)
  case HSVArithmetic // (0.0, 1.0, 0.0)
  case Lab // (87.73, -86.18, 83.18)
  case Luv // (87.73, -83.07, 107.4)
  case Lch // (87.73, 119.l77, 107.4)
  case CMYK // (1, 0, 1)
  case XYZ // (35.76, 71.52, 11.92)
  case Yxy // (71.52, 0.3, 0.6)
  case grayScale // (1.0)

  public var model: ColorModel {
    switch self {
    case .RGBArithmetic,
         .RGBPercentage,
         .RGB8BitNumeric,
         .RGB8BitHexadecimal,
         .HSL,
         .HSLArithmetic,
         .HSB,
         .HSBArithmetic,
         .HSV,
         .HSVArithmetic:
      return .RGB
    case .Lab: return .Lab
    case .Luv, .Lch: return .Lab
    case .CMYK: return .CMYK
    case .XYZ, .Yxy: return .XYZ
    case .grayScale: return .grayScale
    }
  }
}
