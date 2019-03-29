//
//  PageStoreSubscriber.swift
//  ReSwiftConsumer
//
//  Created by brownsoo han on 2017. 10. 23..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import ReSwift

public protocol AnyPageStoreSubscriber: class {
    func _newAnyState(state: Any)
}

public protocol PageStoreSubscriber: AnyPageStoreSubscriber {
    associatedtype PageStoreSubscriberStateType

    func newPageState(state: PageStoreSubscriberStateType)
}

public extension PageStoreSubscriber {
    
    func _newAnyState(state: Any) {
        if let typedState = state as? PageStoreSubscriberStateType {
            newPageState(state: typedState)
        }
    }
}


public class RePageStoreSubscriber<S>: StoreSubscriber {
    
    public typealias StoreSubscriberStateType = S
    private var subscriber: AnyPageStoreSubscriber?
    
    public func newState(state: S) {
        self.subscriber?._newAnyState(state: state)
    }
    
    init(subscriber: AnyPageStoreSubscriber) {
        self.subscriber = subscriber
    }
    
}
