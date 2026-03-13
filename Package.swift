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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/3.3.0/payo.xcframework.zip",
            checksum: "37cf771fcb675a426eba0ca0ac6efd7e15079b8b0c4eed80d8b2e71248d9fe02"
        ),
    ]
)
