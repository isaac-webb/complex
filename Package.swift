// swift-tools-version:5.1

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
