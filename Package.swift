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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/3.1.0/payo.xcframework.zip",
            checksum: "efb85ef7ff1fe0bb5e9b4cd402afe32dc49f0244aa47f8766436763b2507d576"
        ),
    ]
)
