//
//  StateSharedViewController.swift
//  ReSwiftConsumer
//
//  Created by brownsoo on 2017. 12. 23..
//  Copyright © 2017년 Hansoo Labs. All rights reserved.
//

import ReSwift
import UIKit

open class StateSharedViewController<State>: UIViewController
    where State: Equatable & StateType {

    private(set) open var sharedStore: Store<State>?

    open func bind(store: Store<State>?) {
        self.sharedStore = store
    }

    deinit {
        sharedStore = nil
    }
}
