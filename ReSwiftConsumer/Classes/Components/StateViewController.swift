//
//  StateViewController.swift
//  ReSwiftConsumer
//
//  Created by brownsoo han on 2017. 10. 18..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

open class StateViewController<ReState> : UIViewController where ReState: StateType & Equatable {
    
    open var pageInteractor: RePageInteractor<ReState>?
    
    open var pageStore: Store<ReState>? {
        return pageInteractor?.pageStore ?? nil
    }
    open var pageConsumer: StateConsumer<ReState>? {
        return pageInteractor?.pageConsumer
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        // make subsrcription on PageStore
        pageInteractor?.bindState()
    }

    deinit {
        // unsubscription on PageStore
        pageInteractor?.unbindState()
    }
}


