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

class MainInteractor: RePageInteractor<MainState>, StoreSubscriber {
    
    typealias StoreSubscriberStateType = AppState
    
    let appConsumer = StateConsumer<AppState>()

    override func getPageReducer() -> (Action, MainState?) -> MainState {
        return mainReducer
    }
    
    override func getPageInitialState() -> MainState? {
        return MainState()
    }
    
    override func getPageMiddleWares() -> [Middleware<MainState>] {
        let middle: Middleware<MainState> = { dispatch, getState in
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

    // ReSwift StoreSubscriber implements
    func newState(state: AppState) {
        appConsumer.consume(newState: state)
    }

    // MARK: consumer callbacks

    private func onForegroundChanged(curr: Bool) {
        print("MainInteractor-  foreground \(curr)")
    }
}
