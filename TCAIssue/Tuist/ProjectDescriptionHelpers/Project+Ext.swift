//
//  Project+Ext.swift
//  iOS_ServBigManifests
//
//  Created by Bakr mohamed on 22/07/2024.
//

import ProjectDescription

extension Target {
    public static func addTarget(
        schemeName: String,
        appDisplayName: String,
        bundleId: String,
        versionNo: String,
        buildNo: String
    ) -> Target {
        Target.target(
            name: schemeName,
            destinations: [.iPhone, .iPad, .mac],
            product: .app,
            productName: schemeName,
            bundleId: bundleId,
            deploymentTargets: .multiplatform(iOS: "15.0", macOS: "12.0"),
            infoPlist: .file(path: .path("TargetsConfiguration/\(schemeName)/\(schemeName).plist")),
            sources: [
                "Application/**"
            ],
            resources: [
                "TargetsConfiguration/\(schemeName)/Resources/**"
            ],
            entitlements: .file(path: "TargetsConfiguration/\(schemeName)/\(schemeName).entitlements"),
            dependencies: [
                .package(product: "ComposableArchitecture")
            ],
            settings: .settings(
                base: [
                    "DEVELOPMENT_TEAM": "",
                    "ENABLE_USER_SCRIPT_SANDBOX": "NO",
                    "ASSETCATALOG_COMPILER_GENERATE_ASSETS": "NO",
                    "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
                    "INFOPLIST_FILE": "TargetsConfiguration/\(schemeName)/\(schemeName).plist",
                    "MARKETING_VERSION": .string(versionNo), // This is CFBundleShortVersionString
                    "CURRENT_PROJECT_VERSION": .string(buildNo), // This is CFBundleVersion,
                    "DISPLAY_NAME": .string(appDisplayName),
                    "PRODUCT_NAME": .string(appDisplayName),
                    "SWIFT_VERSION": "5.9",
                    "OTHER_SWIFT_FLAGS": ["$(inherited)"],
                    "ARCHS": "$(ARCHS_STANDARD)",
                    "DISABLE_PARALLELIZATION": "YES"
                ],
                configurations: [
                    .debug(name: "Development", xcconfig: .path("TargetsConfiguration/\(schemeName)/Configuration/Development.xcconfig")),
                    .debug(name: "Staging", xcconfig: .path("TargetsConfiguration/\(schemeName)/Configuration/Staging.xcconfig")),
                    .release(name: "Production", xcconfig: .path("TargetsConfiguration/\(schemeName)/Configuration/Production.xcconfig")),
                ]
            )
        )
    }
}


extension Scheme {
    public static func makeScheme(for target: Target) -> Scheme {
        return scheme(
            name: "\(target.name)",
            shared: true,
            buildAction: .buildAction(targets: [TargetReference(stringLiteral: target.name)]),
            runAction: .runAction(
                configuration: "Development",
                arguments: .arguments(
                    environmentVariables: [
                        "IDEPreferLogStreaming":"YES"
                    ],
                    launchArguments: [.launchArgument(name: "-FIRDebugEnabled", isEnabled: true)]
                )
            )
        )
    }
}
