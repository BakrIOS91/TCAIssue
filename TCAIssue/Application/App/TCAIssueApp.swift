//
//  TCAIssueApp.swift
//  TCAIssue
//
//  Created by Bakr mohamed on 18/09/2024.
//

import SwiftUI

@main
struct TCAIssueApp: App {
    var body: some Scene {
        WindowGroup {
            AppMasterView(
                store: .init(
                    initialState: AppMasterFeature.State()
                ){
                    AppMasterFeature()
                }
            )
        }
    }
}
