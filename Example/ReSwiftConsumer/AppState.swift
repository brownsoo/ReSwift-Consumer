//
//  AppState.swift
//  ReSwiftConsumer_Example
//
//  Created by brownsoo on 2017. 12. 25..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType, Equatable {
    var foreground: Bool = false
    public static func ==(lhs: AppState, rhs: AppState) -> Bool {
        return lhs.foreground == rhs.foreground
    }
}



protocol AppAction: Action {}
struct AppActionSetForeground: AppAction { let foreground: Bool }



func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    switch action {
    case let it as AppActionSetForeground:
        state.foreground = it.foreground
    default:
        break
    }
    return state
}
