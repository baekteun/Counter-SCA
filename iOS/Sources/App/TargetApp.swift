//
//  TargetApp.swift
//  Target
//
//  
//

import SwiftUI
import ComposableArchitecture

@main
struct TargetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(
                initialState: CounterState(),
                reducer: counterReducer,
                environment: .live)
            )
        }
    }
}
