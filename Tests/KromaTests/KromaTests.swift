import XCTest
import SwiftUI
@testable import Kroma

final class KromaTests: XCTestCase {

  func testRGBComponentsCustomColor() {
    let color = Color(.sRGB, red: 0.5, green: 0.5, blue: 0.5, opacity: 1.0)
    let rgb = color.rgbComponents
    XCTAssertEqual(rgb.red, 0.5)
    XCTAssertEqual(rgb.green, 0.5)
    XCTAssertEqual(rgb.blue, 0.5)
  }

  func testRGBComponentsPredefinedColor() {
    let rgb = Color.purple.rgbComponents
    XCTAssertEqual(round(rgb.red * 255), 175)
    XCTAssertEqual(round(rgb.green * 255), 82)
    XCTAssertEqual(round(rgb.blue * 255), 222)
  }

  func testHSBConversion() {
    let color = Color(.sRGB, red: 0.5, green: 0.5, blue: 0.5, opacity: 1.0)
    let hsb = color.rgbComponents.toHSB()
    XCTAssertEqual(hsb.hue, 0)
    XCTAssertEqual(hsb.saturation, 0)
    XCTAssertEqual(hsb.brightness, 0.5)
  }

  func testLighter() {
    let color = RGBArithmetic(red: 1.0, green: 0, blue: 0)
    let rgb = color.lighter(by: 0.5)
    XCTAssertEqual(rgb.red, 1)
    XCTAssertEqual(rgb.green, 0.5)
    XCTAssertEqual(rgb.blue, 0.5)
  }

  func testDarker() {
    let color = RGBArithmetic(red: 1.0, green: 0, blue: 0)
    let rgb = color.darker(by: 0.5)
    XCTAssertEqual(rgb.red, 0.5)
    XCTAssertEqual(rgb.green, 0.0)
    XCTAssertEqual(rgb.blue, 0.0)
  }

  func testLuma() {
    let color = Color.purple
    XCTAssertLessThanOrEqual(color.luma - 0.438, 0.001)
  }

  func testIsLight() {
    XCTAssertFalse(Color.purple.isLight)
    XCTAssertTrue(Color.white.isLight)
    XCTAssertTrue(Color.yellow.isLight)
    XCTAssertFalse(Color.red.isLight)
  }
}
