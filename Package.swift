// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserDefaultsBacked",
    platforms: [
        .iOS(.v10),
        .watchOS(.v2),
        .tvOS(.v9),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "UserDefaultsBacked",
            targets: ["UserDefaultsBacked"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "UserDefaultsBacked",
            dependencies: []),
        .testTarget(
            name: "UserDefaultsBackedTests",
            dependencies: ["UserDefaultsBacked"]),
    ]
)
