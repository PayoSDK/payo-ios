// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "payo",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "payo", targets: ["payo"]),
    ],
    targets: [
        .binaryTarget(
            name: "payo",
            url: "PLACEHOLDER",
            checksum: "PLACEHOLDER"
        ),
    ]
)
