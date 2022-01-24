//
//  Counter.swift
//  Counter
//
//  Created by 최형우 on 2022/01/23.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation

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

struct gi{
    var generateRandom: (ClosedRange<Int>) -> Int
    var uuid: UUID
    
    static let live = CounterEnvironment(
        generateRandom: Int.random(in:),
        uuid: UUID.init
    )
}


