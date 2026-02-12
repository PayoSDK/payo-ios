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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/1.0.0/payo.xcframework.zip",
            checksum: "c9c2b7de9a50d4fec462daf1d244c8721ebf744b13138edfd85f8222143a439a"
        ),
    ]
)
