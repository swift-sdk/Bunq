// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "BunqTests",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .executable(name: "t_bunq", targets: ["BunqTests"]),
        .executable(name: "t_bunq_live", targets: ["BunqLive"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-lco/Milieu.git", branch: "master"),
        .package(path: ".."),
    ],
    targets: [
        .executableTarget(
            name: "BunqTests",
            dependencies: [.product(name: "Bunq", package: "Bunq")]
        ),
        .executableTarget(
            name: "BunqLive",
            dependencies: [.product(name: "Bunq", package: "Bunq"), .product(name: "Milieu", package: "Milieu")]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    switch target.type {
    case .regular, .executable, .test, .macro:
        var settings = target.swiftSettings ?? []
        settings.append(.treatAllWarnings(as: .error))
        settings.append(.unsafeFlags(["-continue-building-after-errors"]))
        target.swiftSettings = settings

    case .plugin, .system, .binary:
        break

    @unknown default:
        break
    }
}
