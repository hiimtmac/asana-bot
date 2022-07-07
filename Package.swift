// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "asana-bot",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "AsanaBot", targets: ["Run"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.11.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.1.0"),
        .package(url: "https://github.com/hiimtmac/chat-kit.git", branch: "main")
    ],
    targets: [
        .executableTarget(name: "Run", dependencies: [
            .target(name: "App"),
            .product(name: "ArgumentParser", package: "swift-argument-parser")
        ]),
        .target(name: "Networking", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client")
        ]),
        .target(name: "GithubKit", dependencies: [
            .target(name: "Networking"),
            .product(name: "AsyncHTTPClient", package: "async-http-client")
        ]),
        .target(name: "AsanaKit", dependencies: [
            .target(name: "Networking"),
            .product(name: "AsyncHTTPClient", package: "async-http-client")
        ]),
        .target(name: "App", dependencies: [
            .target(name: "GithubKit"),
            .target(name: "AsanaKit"),
            .target(name: "Networking"),
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
            .product(name: "SlackKit", package: "chat-kit")
        ]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .target(name: "Networking"),
            .product(name: "AsyncHTTPClient", package: "async-http-client")
        ]),
        .testTarget(name: "GithubKitTests", dependencies: [
            .target(name: "Networking"),
            .target(name: "GithubKit"),
            .product(name: "AsyncHTTPClient", package: "async-http-client")
        ]),
        .testTarget(name: "AsanaKitTests", dependencies: [
            .target(name: "Networking"),
            .target(name: "AsanaKit"),
            .product(name: "AsyncHTTPClient", package: "async-http-client")
        ]),
    ]
)
