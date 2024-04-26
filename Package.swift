//swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "GLTFKit2",
    platforms: [
        .iOS("12.1")
    ],
    products: [
        .library(name: "GLTFKit2",
                 targets: [ "GLTFKit2" ])
    ],
    targets: [
        .binaryTarget(name: "GLTFKit2",
                      url: "https://github.com/daninils/GLTFKit2/releases/download/0.5.9/GLTFKit2.xcframework.zip",
                      checksum:"56f538ae7a7c08f78f8726edaa3600b1ca6a5ebc5b4b07330ae6ba13134059ee")
    ]
)
