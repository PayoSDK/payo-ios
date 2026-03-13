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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/3.4.0/payo.xcframework.zip",
            checksum: "3e325216732c3fe48cbb7cd55da4014cfb9c5f3bca30e7108e838784fb6c2d93"
        ),
    ]
)
