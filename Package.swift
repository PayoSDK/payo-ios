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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/3.2.0/payo.xcframework.zip",
            checksum: "9b4c528464506162e08bd7b97798f9aea8e0c27c8f313ea273c1948be618f3e8"
        ),
    ]
)
