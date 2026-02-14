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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/2.0.0/payo.xcframework.zip",
            checksum: "2c3ecf747f9e380d3c4ced64009e7fbfc45557390fdb580814b8a9c67a8c98d4"
        ),
    ]
)
