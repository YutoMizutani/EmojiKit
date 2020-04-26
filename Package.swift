// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EmojiKit",
    products: [
        .library(name: "EmojiKit",
                 targets: ["EmojiKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/pvieito/PythonKit.git", .branch("swift-5.1"))
    ],
    targets: [
        .target(name: "EmojiKit",
                dependencies: ["PythonKit"]),
        .testTarget(name: "EmojiKitTests",
                    dependencies: ["EmojiKit"])
    ]
)
