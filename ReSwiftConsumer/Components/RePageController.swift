//
//  RePageController.swift
//  ReSwiftConsumer
//
//  Created by brownsoo han on 2017. 10. 18..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation
import ReSwift

/// The RePageController class defines the relations between RePageStore and ReSwift's middleware.
/// And it provides a StateConsumer of StateType.
@available(*, unavailable, renamed: "RePageController")
open class RePageInteractor<PS: StateType> : NSObject {}
open class RePageController<PS: StateType> : NSObject, PageStoreSubscriber {
    
    public typealias PageStoreSubscriberStateType = PS
    
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

    public var sharedConsumers = Set<StateConsumer<PS>>()

    required public override init() {
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
    }
    
    open func newPageState(state: PS) {
        for consumer in sharedConsumers {
            consumer.consume(new: state)
        }
    }

    public func addSharedConsumer(_ consumer: StateConsumer<PS>) {
        sharedConsumers.update(with: consumer)
        if consumer.consumeInstantly {
            consumer.consume(new: pageStore.state)
        }
    }

    public func removeSharedConsumer(_ consumer: StateConsumer<PS>) {
        sharedConsumers.remove(consumer)
    }
}

