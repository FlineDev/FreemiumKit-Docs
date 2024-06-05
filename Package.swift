// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "FreemiumKit",
    products: [.library(name: "FreemiumKit", targets: ["FreemiumKit"])],
    dependencies: [.package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0")],
    targets: [.target(name: "FreemiumKit")]
)
