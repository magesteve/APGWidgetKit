// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APGWidgetKit",
    platforms: [
        .iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8)
    ],
    products: [
        .library(
            name: "APGWidgetKit",
            targets: ["APGWidgetKit"]),
    ],
    targets: [
        .target(
            name: "APGWidgetKit"),
        .testTarget(
            name: "APGWidgetKitTests",
            dependencies: ["APGWidgetKit"]
        ),
    ]
)
