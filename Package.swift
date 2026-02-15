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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/2.6.0/payo.xcframework.zip",
            checksum: "b675d3219b4a51648e85f258cc1de4a74db938f7e6706cb714a86ba1d0baca5f"
        ),
    ]
)
