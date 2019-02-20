//
//  StateNavigationController.swift
//  ReSwiftConsumer
//
//  Created by brownsoo han on 2017. 11. 2..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

open class StateNavigationController<ReState>: UINavigationController where ReState: StateType {
    
    open var pageInteractor: RePageInteractor<ReState>?
    
    open var pageStore: Store<ReState>? {
        return pageInteractor?.pageStore ?? nil
    }
    open var pageConsumer: StateConsumer<ReState>? {
        return pageInteractor?.pageConsumer
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        // makes subscription on PageStore
        pageInteractor?.bindState()
    }

    deinit {
        // unsubscription on PageStore
        pageInteractor?.unbindState()
    }
}

