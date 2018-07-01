// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to
// build this package.

import PackageDescription

let package = Package(
    name: "Complex",
    products: [
        .library(
            name: "Complex",
            targets: ["Complex"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Complex",
            dependencies: []),
        .testTarget(
            name: "ComplexTests",
            dependencies: ["Complex"]),
    ]
)
