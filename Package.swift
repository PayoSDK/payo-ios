// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "payo-ios",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "payo", targets: ["payo"]),
    ],
    targets: [
        .binaryTarget(
            name: "payo",
            url: "https://github.com/PayoSDK/payo-ios/releases/download/1.3.0/payo.xcframework.zip",
            checksum: "6df9b34f76287e0dedd5e854eb8b628dedcf64c87f6e37633781d70b7ca023f9"
        ),
    ]
)
