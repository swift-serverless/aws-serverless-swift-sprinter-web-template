// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Hello",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(name: "Hello", targets: ["Hello"]),
        .library(
            name: "ProductService",
            targets: ["ProductService"]
        ),
        .library(
            name: "BootstrapPlot",
            targets: ["BootstrapPlot"]
        ),
        .library(
            name: "WebController",
            targets: ["WebController"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/swift-sprinter/aws-lambda-swift-sprinter-nio-plugin", from: "1.0.0"),
        .package(url: "https://github.com/swift-aws/aws-sdk-swift.git", from: "5.0.0-alpha.3"),
        .package(url: "https://github.com/johnsundell/plot.git", from: "0.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Hello",
            dependencies: [
                "ProductService",
                "LambdaSwiftSprinterNioPlugin",
                "BootstrapPlot",
                "WebController",
            ]
        ),
        .target(
            name: "WebController",
            dependencies: [
                "ProductService",
                "Plot",
                "BootstrapPlot"
            ]
        ),
        .target(
            name: "ProductService",
            dependencies: [
                .product(name: "AWSDynamoDB", package: "aws-sdk-swift"),
            ]
        ),
        .target(
            name: "BootstrapPlot",
            dependencies: ["Plot"]
        ),
        .testTarget(
            name: "HelloTests",
            dependencies: ["Hello"]
        ),
    ]
)
