import PackageDescription

let package = Package(
    name: "ShinyApple",
    dependencies: [
        .package(url: "https://github.com/kylef/Commander.git"),
    ],
    targets: [
        .target(
            name: "ShinyApple",
            dependencies: ["Commander"]),
    ]
)
