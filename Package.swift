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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/1.2.0/payo.xcframework.zip",
            checksum: "522f9129b7a7df87cd5034e08eff02ea875d804e8573669c5c68998c4cb65d7e"
        ),
    ]
)
