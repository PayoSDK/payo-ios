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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/1.0.3/payo.xcframework.zip",
            checksum: "69a9b1cda9c98ae5d17117cdaaef1e5e53f461e5456f3dbb58c5bae56499eeea"
        ),
    ]
)
