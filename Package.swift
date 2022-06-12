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

#if swift(>=5.6)
  package.dependencies.append(
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  )
#endif
