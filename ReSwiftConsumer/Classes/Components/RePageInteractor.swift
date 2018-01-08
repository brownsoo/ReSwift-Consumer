//
//  ReStateInteractor.swift
//  ReSwiftConsumer
//
//  Created by brownsoo han on 2017. 10. 18..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

open class RePageInteractor<PS: StateType & Equatable>: PageStoreSubscriber {
    
    public typealias PageStoreSubscriberStateType = PS
    
    open var pageStore:Store<PS>?
    open var pageStoreScriber: RePageStoreSubscriber<PS>?
    open let pageConsumer = StateConsumer<PS>()
    
    public init() {
    }
    
    open func getPageReducer() -> Reducer<PS> {
        preconditionFailure("must be overridden")
    }
    
    open func getPageMiddleWares() -> [Middleware<PS>] {
        return []
    }
    
    open func getPageInitialState() -> PS? {
        return nil
    }
    
    open func bindState() -> Void {
        
        var middleWare = Array<Middleware<PS>>()
        middleWare.append(contentsOf: getPageMiddleWares())
        
        pageStore = Store<PS>(
            reducer: getPageReducer(),
            state: getPageInitialState(),
            middleware: middleWare)
        
        pageStoreScriber = RePageStoreSubscriber(subscriber: self)
        pageStore?.subscribe(pageStoreScriber!) { subscription in
            subscription.skipRepeats()
        }
    }
    
    open func unbindState() {
        pageConsumer.removeAll()
        if pageStoreScriber != nil {
            pageStore?.unsubscribe(pageStoreScriber!)
        }
    }
    
    public func newPageState(state: PS) {
        self.pageConsumer.consume(newState: state)
    }
    
}

