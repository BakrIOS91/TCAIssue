import ProjectDescription
import ProjectDescriptionHelpers

let appTargets: [Target] = [
    .addTarget(
        schemeName: "TCAIssue",
        appDisplayName: "TCAIssue",
        bundleId: "com.BM.TCAIssue",
        versionNo: "1",
        buildNo: "1"
    )
]

let schemes = appTargets.map { Scheme.makeScheme(for: $0) }

let project = Project(
    name: "TCAIssue",
    organizationName: "BMSoftware",
    options: .options(
        defaultKnownRegions: ["ar-EG", "en-US"],
        developmentRegion: "ar-EG",
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
    ),
    packages: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .exact("1.15.0"))
        
    ],
    settings: .settings(configurations: [
        .debug(name: "Development"),
        .debug(name: "Staging"),
        .release(name: "Production")
    ]),
    targets: appTargets,
    schemes: schemes
)
