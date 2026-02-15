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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/2.7.0/payo.xcframework.zip",
            checksum: "3bba541d945b79cc79a05fae21abac54c455d9c7eb781d71bd118b51721df218"
        ),
    ]
)
