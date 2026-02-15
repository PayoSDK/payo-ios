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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/2.1.0/payo.xcframework.zip",
            checksum: "3de574a528650d4f0ba5432d71377753719a975d1c4b8c5be379ee524677dd7a"
        ),
    ]
)
