// swift-tools-version:5.3
import PackageDescription

let sdkName = "CorrilySDK"

let package = Package(
  name: sdkName,
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15)
  ],
  products: [
    .library(name: sdkName, targets: [sdkName]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: sdkName
    ),
  ]
)
