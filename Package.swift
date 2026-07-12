// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "ArchitectureShowcase",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "MVVMFeature", targets: ["MVVMFeature"]),
        .library(name: "MVVMCoordinatorFeature", targets: ["MVVMCoordinatorFeature"]),
        .library(name: "ReduxFeature", targets: ["ReduxFeature"])
    ],
    targets: [
        .target(name: "Domain"),
        .target(name: "MVVMFeature", dependencies: ["Domain"]),
        .target(name: "MVVMCoordinatorFeature", dependencies: ["Domain"]),
        .target(name: "ReduxFeature", dependencies: ["Domain"]),
        .testTarget(name: "MVVMFeatureTests", dependencies: ["MVVMFeature", "Domain"]),
        .testTarget(name: "MVVMCoordinatorFeatureTests", dependencies: ["MVVMCoordinatorFeature", "Domain"]),
        .testTarget(name: "ReduxFeatureTests", dependencies: ["ReduxFeature", "Domain"])
    ]
)
