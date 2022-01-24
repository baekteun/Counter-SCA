//
//  Counter.swift
//  Counter
//
//  Created by 최형우 on 2022/01/23.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct CounterState: Equatable, Identifiable{
    var count = 0
    var secret = Int.random(in: -100...100)
    
    var id: UUID = UUID()
}

extension CounterState{
    var countString: String{
        get { String(count) }
        set { count = Int(newValue) ?? count}
    }
    
    var countFloat: Float{
        get { Float(count) }
        set { count = Int(newValue) }
    }
    
    enum CheckResult{
        case lower, equal, higher
    }
    
    var checkResult: CheckResult{
        if count < secret { return .lower }
        if count > secret { return .higher }
        return .equal
    }
}

enum CounterAction: Equatable{
    case increment
    case decrement
    case setCount(String)
    case slidingCount(Float)
    case playNext
}

struct CounterEnvironment{
    var generateRandom: (ClosedRange<Int>) -> Int
    var uuid: () -> UUID
    
    static let live = CounterEnvironment(
        generateRandom: Int.random(in:),
        uuid: UUID.init
    )
}

let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment>{ state, action, env in
    switch action{
    case .increment:
        state.count += 1
        return .none
    case .decrement:
        state.count -= 1
        return .none
    case let .setCount(text):
        state.countString = text
        return .none
    case let .slidingCount(val):
        state.countFloat = val
        return .none
    case .playNext:
        state.count = 0
        state.secret = env.generateRandom(-100...100)
        state.id = env.uuid()
        return .none
    }
}.debug()
