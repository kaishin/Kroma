import Foundation
import CoreImage

public enum ColorModel {
  case RGB
  case Lab
  case Luv
  case CMYK
  case XYZ
  case grayScale
}

#if canImport(CoreImage)
extension ColorModel {

  public var cfString: CFString? {
    switch self {
    case .RGB:
      return kCGImagePropertyColorModelRGB
    case .Lab:
      return kCGImagePropertyColorModelLab
    case .CMYK:
      return kCGImagePropertyColorModelCMYK
    case .grayScale:
      return kCGImagePropertyColorModelGray
    default:
      return nil
    }
  }
}
#endif
