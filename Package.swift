// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Name",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "Name",
            type: .dynamic,
            targets: ["Name"]
        ),
    ],
    targets: [
        .target(
            name: "Name",
            path: "Sources"            
        ),
        .testTarget(
            name: "NameTests",
            dependencies: ["Name"]
        ),
    ]
)
