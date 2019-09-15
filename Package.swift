// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EmojiKit",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "EmojiKit",
            targets: ["EmojiKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CLibemoji",
            path: "Sources/CLibemoji",
            cSettings: [
                // -Xcc -Iexternals/libemoji/src
                .unsafeFlags(["-I", "externals/libemoji/src"]),
                // -Xcc -Iexternals/libemoji/externals/skia
                .unsafeFlags(["-I", "externals/libemoji/externals/skia"]),
                // -Xcc -Iexternals/libemoji/externals/skia/include/core
                .unsafeFlags(["-I", "externals/libemoji/externals/skia/include/core"]),
                // -Xcc -Iexternals/libemoji/externals/skia/include/config
                .unsafeFlags(["-I", "externals/libemoji/externals/skia/include/config"]),
                // -Xcc -Iexternals/libemoji/externals/skia/include/utils
                .unsafeFlags(["-I", "externals/libemoji/externals/skia/include/utils"]),
                // -Xcc -Iexternals/libemoji/externals/skia/include/gpu
                .unsafeFlags(["-I", "externals/libemoji/externals/skia/include/gpu"]),
            ],
            linkerSettings: [
                // -Xlinker -Lexternals/libemoji/tmp
                .unsafeFlags(["-L", "externals/libemoji/tmp"]),
                // -Xlinker -lemoji_combined
                .linkedLibrary("emoji_combined"),
                // -Xlinker -lemoji
                .linkedLibrary("emoji"),
                // -Xlinker -lskia
                .linkedLibrary("skia"),
                // -Xlinker -lc++
                .linkedLibrary("c++"),
                // -Xlinker -lz
                .linkedLibrary("z"),
                // -Xlinker -framework -Xlinker CoreFoundation
                .linkedFramework("CoreFoundation"),
                // // -Xlinker -framework -Xlinker CoreGraphics
                .linkedFramework("CoreGraphics"),
                // // -Xlinker -framework -Xlinker CoreText
                .linkedFramework("CoreText"),
                // // -Xlinker -framework -Xlinker CoreServices
                .linkedFramework("CoreServices"),
            ]),
        .target(
            name: "EmojiKit",
            dependencies: ["CLibemoji"],
            path: "Sources/EmojiKit"),
        .testTarget(
            name: "EmojiKitTests",
            dependencies: ["EmojiKit"]),
    ],
    cLanguageStandard: PackageDescription.CLanguageStandard.c11,
    cxxLanguageStandard: PackageDescription.CXXLanguageStandard.cxx14
)
