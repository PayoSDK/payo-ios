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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/2.2.0/payo.xcframework.zip",
            checksum: "a6b67fb5ebecf0410be1e2ea59e1136bb0abdfd4e67511422c1a8debebcd44ef"
        ),
    ]
)
