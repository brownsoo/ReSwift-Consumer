//
//  MainPageState.swift
//  ReSwiftConsumer_Example
//
//  Created by brownsoo on 2017. 12. 25..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation
import ReSwift

struct MainPageState: StateType, Equatable {
    var count: Int = 10
}


protocol MainAction: Action {}
struct MainActionIncreaseCount: MainAction {}
struct MainActionDecreaseCount: MainAction {}


func mainReducer(action: Action, state: MainPageState?) -> MainPageState {
    var state = state ?? MainPageState()
    switch action {
    case _ as MainActionIncreaseCount:
        state.count += 1
    case _ as MainActionDecreaseCount:
        state.count -= 1
    default:
        break
    }
    return state
}

