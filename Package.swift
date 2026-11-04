// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "DarshanFileManager",
    platforms: [.macOS(.v13), .iOS(.v16)],
    products: [
        .library(name: "DarshanCore", targets: ["DarshanCore"]),
        .library(name: "DarshanUI", targets: ["DarshanUI"]),
    ],
    targets: [
        .target(name: "DarshanCore"),
        .target(name: "DarshanUI", dependencies: ["DarshanCore"]),
        .testTarget(name: "DarshanCoreTests", dependencies: ["DarshanCore"]),
        .testTarget(name: "DarshanUITests", dependencies: ["DarshanUI", "DarshanCore"]),
    ]
)
