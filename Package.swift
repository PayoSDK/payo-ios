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
            checksum: "bd35d261fd7c6ade74bded40b2294431f9a14aa2d1e415e2cb2486e5df25bf61"
        ),
    ]
)
