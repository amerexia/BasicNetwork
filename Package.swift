// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "BasicNetwork",
    platforms: [.iOS(.v12), .macOS(.v10_14), .tvOS(.v12), .watchOS(.v5)],
    products: [
        .library(name: "BasicNetwork", targets: ["BasicNetwork"])
    ],
    targets: [
        .target(
            name: "BasicNetwork",
            path: "Sources"
        )
    ]
)
