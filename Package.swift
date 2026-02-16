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
            url: "https://github.com/PayoSDK/payo-ios/releases/download/3.0.0/payo.xcframework.zip",
            checksum: "870e35ea869f9611cf52f2665f0e26fe7bd5b6e422089b3420f3bc76405e7117"
        ),
    ]
)
