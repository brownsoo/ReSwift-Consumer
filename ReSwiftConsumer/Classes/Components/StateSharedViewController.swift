//
//  StateSharedViewController.swift
//  ReSwiftConsumer
//
//  Created by brownsoo on 2017. 12. 23..
//  Copyright © 2017년 Hansoo Labs. All rights reserved.
//

import ReSwift
import UIKit

open class StateSharedViewController<SharedState: StateType>: UIViewController, StateShared where SharedState: Equatable {
    
    public typealias S = SharedState
    
    private(set) open var sharedStore: Store<SharedState>?
    private(set) open var sharedConsumer: StateConsumer<SharedState>?
    
    open func bind(store: Store<SharedState>, consumer: StateConsumer<SharedState>) {
        self.sharedStore = store
        self.sharedConsumer = consumer
    }
}
