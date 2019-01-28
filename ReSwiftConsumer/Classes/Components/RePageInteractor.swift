//
//  ReStateInteractor.swift
//  ReSwiftConsumer
//
//  Created by brownsoo han on 2017. 10. 18..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation
import ReSwift

open class RePageInteractor<PS: StateType>: PageStoreSubscriber,
    RePageStoreInteract {
    
    public typealias PageStoreSubscriberStateType = PS
    public typealias PageStoreInteractStateType = PS
    
    open lazy var pageStore:Store<PS> = {
        var middleWare = Array<Middleware<PS>>()
        middleWare.append(contentsOf: getPageMiddleWares())
        let store = Store<PS>(
            reducer: getPageReducer(),
            state: getPageInitialState(),
            middleware: middleWare)
        return store
    }()

    open lazy var pageStoreSubscriber: RePageStoreSubscriber<PS> = RePageStoreSubscriber(subscriber: self)

    open lazy var pageConsumer = StateConsumer<PS>()

    public var sharedConsumers = Set<StateConsumer<PS>>()

    private var _pageStore: Store<PS>?

    required public init() {
    }
    
    open func getPageReducer() -> Reducer<PS> {
        return { (action, state) in return state! }
    }
    
    open func getPageMiddleWares() -> [Middleware<PS>] {
        return []
    }
    
    open func getPageInitialState() -> PS? {
        return nil
    }
    
    open func bindState() {
        pageStore.subscribe(pageStoreSubscriber)
    }
    
    open func unbindState() {
        pageStore.unsubscribe(pageStoreSubscriber)
        for consumer in sharedConsumers {
            consumer.removeAll()
        }
        sharedConsumers.removeAll()
        pageConsumer.removeAll()
    }
    
    open func newPageState(state: PS) {
        for consumer in sharedConsumers {
            consumer.consume(newState: state)
        }
        pageConsumer.consume(newState: state)
    }

    public func addSharedConsumer(_ consumer: StateConsumer<PS>) {
        sharedConsumers.insert(consumer)
    }

    public func removeSharedConsumer(_ consumer: StateConsumer<PS>) {
        sharedConsumers.remove(consumer)
    }
}

