//
//  ContentView.swift
//  TCAIssue
//
//  Created by Bakr mohamed on 18/09/2024.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ContentFeature {
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
        Reduce {
            state,
            action in
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

struct ContentView: View {
    
    @Perception.Bindable var store: StoreOf<ContentFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                Button {
                    store.send(.didPressOnShowSheet)
                } label: {
                    Text("Press here to show sheet")
                }
                .padding()
            }
            .padding()
            .sheet(isPresented: $store.showSheet) {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!\n from sheet")
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView(
        store: .init(
            initialState: ContentFeature.State()
        ){
            ContentFeature()
                ._printChanges()
        }
    )
}
