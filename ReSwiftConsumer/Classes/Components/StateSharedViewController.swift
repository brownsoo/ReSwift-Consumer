//
//  StateSharedViewController.swift
//  ReSwiftConsumer
//
//  Created by brownsoo on 2017. 12. 23..
//  Copyright © 2017년 Hansoo Labs. All rights reserved.
//

import ReSwift
import UIKit

open class StateSharedViewController<State>: UIViewController, StateShared
    where State: Equatable & StateType {
    
    public typealias StateSharedType = State
    
    private(set) open var sharedStore: Store<State>?

    @available(*, deprecated, message: "Make and use own pageConsumer instead for this in view controller. This will be removed at version 0.6")
    private(set) open var sharedConsumer: StateConsumer<State>?

    public let pageConsumer = StateConsumer<State>()

    @available(*, deprecated, obsoleted: 0.6, message: "This is useless because the sharedConsumer is deprecated.")
    public lazy var consumerBag: ConsumerBag<State>? = { [weak sharedConsumer] in
        guard let sharedConsumer = sharedConsumer else {
            return nil
        }
        return ConsumerBag<State>(sharedConsumer)
    }()

    @available(*, deprecated, message: "This is useless because the sharedConsumer is deprecated. Use bind(store:) instead.")
    open func bind(store: Store<State>?, consumer: StateConsumer<State>?) {
        self.sharedStore = store
        self.sharedConsumer = consumer
    }

    open func bind(store: Store<State>?) {
        self.sharedStore = store
    }
}
