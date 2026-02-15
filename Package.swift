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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/2.4.0/payo.xcframework.zip",
            checksum: "4f83be482d00b60cec8d4e5094f220b570a532d2d56185d595d2a2909e272207"
        ),
    ]
)
