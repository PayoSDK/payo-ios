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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/2.3.0/payo.xcframework.zip",
            checksum: "c902d872addee3a086bf6e52ef8a8e53ed095231600b37839d936743eb609090"
        ),
    ]
)
