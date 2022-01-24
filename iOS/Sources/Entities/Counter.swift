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

enum CounterAction: Equatable{
    case increment
    case decrement
    case setCount(String)
    case slidingCount(Float)
    case playNext
}

