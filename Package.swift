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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/1.5.0/payo.xcframework.zip",
            checksum: "f50e609cdc025f6d4ce23ebe9a1f4c097f8dc23ede5af8dd90a852c26c9a6abe"
        ),
    ]
)
