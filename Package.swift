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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/1.4.0/payo.xcframework.zip",
            checksum: "a3f05c77fbe36691cb471ff989f080db29f2a23093be0099e26d2951a81ba5b4"
        ),
    ]
)
