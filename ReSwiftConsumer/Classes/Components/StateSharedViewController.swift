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
    private(set) open var sharedConsumer: StateConsumer<State>?
    public lazy var consumerBag: ConsumerBag<State>? = { [weak sharedConsumer] in
        guard let sharedConsumer = sharedConsumer else {
            return nil
        }
        return ConsumerBag<State>(sharedConsumer)
    }()
    
    open func bind(store: Store<State>?, consumer: StateConsumer<State>?) {
        self.sharedStore = store
        self.sharedConsumer = consumer
    }
}
