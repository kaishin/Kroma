# Kroma 🟥🟩🟦

![Test](https://github.com/kaishin/Kroma/workflows/Test/badge.svg)
[![GitHub release](https://img.shields.io/github/release/kaishin/Kroma.svg)](https://github.com/kaishin/Kroma/releases/latest) 
![Swift 5.3](https://img.shields.io/badge/Swift-5.3-orange.svg) ![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-lightgrey.svg)

A collection of color extensions and utilities for SwiftUI.

## Install

#### Swift Package Manager (Standalone)

Add Korma as a dependency in your `Package.swift` file:

```swift
dependencies: [
  ...
 .package(url: "https://github.com/kaishin/Kroma.git", from: "0.1.0")
]
```

#### Swift Package Manager (Xcode)

Add `https://github.com/kaishin/Kroma.git` as a dependency in the _Swift Packages_ tab of the Xcode project.

## Usage

### Inspect Color Components

```swift
Color.purple.rgbComponents
// -> (0.68, 0.32, 0.87)
```

### Convert to Other Representations

```swift
Color.purple.rgbComponents.toHSB()
// -> (0.77, 0.63, 0.87)
```
### Lighten or Darken a Color

<img src="https://github.com/kaishin/Kroma/raw/main/lighter-darker.png?raw=true" alt="Logo" width="200">

```swift
Color.purple.rgbComponents // (0.686, 0.322, 0.871)
Color.purple.lighter(by: 0.1).rgbComponents // (0.88, 0.52, 1.0)
Color.purple.darker(by: 0.1).rgbComponents // (0.48, 0.12, 0.67)
```

### Get Luma Value of a Color

```swift
Color.purple.luma // 0.438744325864315
```

You can read more on [luma](https://thoughtbot.com/blog/closer-look-color-lightness) here.

### Check if a Color is Perceived as Light or Dark
```swift
Color.purple.isLight // false
Color.white.isLight // true
Color.yellow.isLight // true
Color.red.isLight // false
```

## License

See LICENSE.
