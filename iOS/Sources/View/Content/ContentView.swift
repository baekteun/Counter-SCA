//
//  ContentView.swift
//  test
//
//  Created by 최형우 on 2022/01/13.
//

import SwiftUI
import ComposableArchitecture
import CasePaths

struct ContentView: View {
    let store: Store<CounterState, CounterAction>
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                checkLabel(with: viewStore.checkResult)
                HStack {
                    Button("-") { viewStore.send(.decrement) }
                    TextField(
                        viewStore.countString,
                        text: viewStore.binding(
                            get: \.countString,
                            send: CounterAction.setCount
                        )
                    )
                        .frame(width: 40)
                        .multilineTextAlignment(.center)
                        .foregroundColor(colorOfCount(viewStore.count))
                    Button("+") { viewStore.send(.increment) }
                }
                Slider(value: viewStore.binding(get: \.countFloat, send: CounterAction.slidingCount), in: -100...100)
                Button("Next") { viewStore.send(.playNext) }
            }.frame(width: 150)
        }
    }
    
    func checkLabel(with result: CounterState.CheckResult) -> some View{
        switch result{
        case .lower:
            return Label("Lower", systemImage: "lessthan.circle")
        case .equal:
            return Label("Equal", systemImage: "checkmark.circle")
        case .higher:
            return Label("Higher", systemImage: "greaterthan.circle")
        }
    }
    
    func colorOfCount(_ val: Int) -> Color?{
        if val == 0 { return nil }
        return val < 0 ? .red : .green
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(
            initialState: CounterState(),
            reducer: counterReducer,
            environment: .live)
        )
    }
}
