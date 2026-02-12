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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/1.1.0/payo.xcframework.zip",
            checksum: "78520870b39ade4f6b9af33cb6619acb8e0ccc3b5c106bd99307aff40bd1057a"
        ),
    ]
)
