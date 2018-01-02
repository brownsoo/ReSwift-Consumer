//
//  MainInteractor.swift
//  ReSwiftConsumer_Example
//
//  Created by brownsoo on 2017. 12. 25..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftConsumer

class MainInteractor: RePageInteractor<MainPageState>, StoreSubscriber {
    
    typealias StoreSubscriberStateType = AppState
    
    let appConsumer = StateConsumer<AppState>()
    
    override func getPageReducer() -> (Action, MainPageState?) -> MainPageState {
        return mainReducer
    }
    
    override func getPageInitialState() -> MainPageState? {
        return MainPageState()
    }
    
    override func getPageMiddleWares() -> [Middleware<MainPageState>] {
        let middle: Middleware<MainPageState> = { dispatch, getState in
            return { next in
                return { action in
                    print("page action: \(action)")
                    return next(action)
                }
            }
        }
        return [middle]
    }
    
    override func bindState() {
        super.bindState()
        appConsumer.add({state in state?.foreground},  onForegroundChanged)
        appStore.subscribe(self) { subscription in
            subscription.skipRepeats()
        }
    }
    
    override func unbindState() {
        super.unbindState()
        appConsumer.removeAll()
        appStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        appConsumer.consume(newState: state)
    }
    
    
    private func onForegroundChanged(curr: Bool) {
        print("MainInteractor-  foreground \(curr)")
    }
}
