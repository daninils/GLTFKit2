// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GLTFKit2",
    platforms: [
        .macOS("11.0"), .iOS("12.1")
    ],
    products: [
        .library(name: "GLTFKit2",
                 targets: [ "GLTFKit2" ])
    ],
    targets: [
        .binaryTarget(name: "GLTFKit2",
                      url: "https://github.com/daninils/GLTFKit2/releases/download/0.5.4/GLTFKit2.xcframework.zip",
                      checksum: "f9779f988bc9fb2f508f283c4be8ee32cc867273791328bd4b326c1903fd427f")
    ]
)
