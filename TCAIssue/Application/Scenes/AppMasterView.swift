//
//  AppMasterView.swift
//  TCAIssue
//
//  Created by Bakr mohamed on 18/09/2024.
//  Copyright © 2024 BMSoftware. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AppMasterFeature{
    
    @ObservableState
    struct State {
        var showSheet = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case didPressOnShowSheet
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didPressOnShowSheet:
                state.showSheet = true
                return .none
            case .binding:
                return .none
            }
        }
    }
    
}

struct AppMasterView: View {
    @Perception.Bindable var store: StoreOf<AppMasterFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Button {
                    store.send(.didPressOnShowSheet)
                } label: {
                    Text("Press to show Sheet")
                }
            }
            .sheet(
                isPresented: $store.showSheet
            ) {
                VStack {
                    Text("Hello World from Sheet")
                }
            }
        }
    }
}

#Preview {
    AppMasterView(
        store: .init(
            initialState: AppMasterFeature.State()
        ){
            AppMasterFeature()
        }
    )
}
