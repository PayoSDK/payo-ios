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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/2.5.0/payo.xcframework.zip",
            checksum: "396ed5d8addf8094ce2de012af331536539fc341c02c4d830c4a71a966289f66"
        ),
    ]
)
