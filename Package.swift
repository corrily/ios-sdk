// swift-tools-version:5.5
import PackageDescription

let sdkName = "CorrilySDK"

let package = Package(
  name: sdkName,
  platforms: [
    .iOS(.v14),
    .macOS(.v11)
  ],
  products: [
    .library(name: sdkName, targets: [sdkName]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: sdkName,
      resources: [
        .process("Resources")
      ]
    ),
  ]
)
