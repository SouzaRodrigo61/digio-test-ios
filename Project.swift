import ProjectDescription

let project = Project(
    name: "Digio",
    options: .options(
        defaultKnownRegions: [
            "pt-BR",
            "en"
        ],
        developmentRegion: "pt-BR"
    ),
    packages: [
        .remote(url: "https://github.com/SimplyDanny/SwiftLintPlugins", requirement: .upToNextMajor(from: "0.57.0")),
    ], 
    settings: .settings(configurations: [
        .debug(name: "Debug", xcconfig: "./xcconfigs/Digio-Project.xcconfig"),
        .release(name: "Release", xcconfig: "./xcconfigs/Digio-Project.xcconfig"),
    ]),
    targets: [
        .target(
            name: "Digio",
            destinations: .iOS,
            product: .app,
            bundleId: "org.digio.application",
            deploymentTargets: .iOS("12.0"),
            sources: ["Source/**"],
            resources: [
                "Source/Resources/**",
            ],
            dependencies: [
                .external(name: "SnapKit"),
                .package(product: "SwiftLintBuildToolPlugin", type: .plugin),
            ],
            settings: .settings(configurations: [
                .debug(name: "Debug", xcconfig: "./xcconfigs/Digio.xcconfig"),
                .release(name: "Release", xcconfig: "./xcconfigs/Digio.xcconfig"),
            ])
        ),
        .target(
            name: "SourceTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "org.digio.application.unitTest",
            sources: ["SourceTests/**"],
            dependencies: [
                .target(name: "Digio"),
                .package(product: "SwiftLintBuildToolPlugin", type: .plugin),
            ]
        )
    ]
)
