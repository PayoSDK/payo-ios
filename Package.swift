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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/2.8.0/payo.xcframework.zip",
            checksum: "3f469316fb3532c005559a33ba1b49ea6ff00278140f78d6509e830f71fa63a6"
        ),
    ]
)
