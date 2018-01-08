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
    
    public typealias S = State
    
    private(set) open var sharedStore: Store<State>?
    private(set) open var sharedConsumer: StateConsumer<State>?
    
    open func bind(store: Store<State>, consumer: StateConsumer<State>) {
        self.sharedStore = store
        self.sharedConsumer = consumer
    }
}
