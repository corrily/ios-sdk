// swift-tools-version:5.3
import PackageDescription

let sdkName = "CorrilySDK"

let package = Package(
    name: sdkName,
    platforms: [
        .iOS(.v11),
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
