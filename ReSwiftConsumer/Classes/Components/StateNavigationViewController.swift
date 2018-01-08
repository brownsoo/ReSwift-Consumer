//
//  StateNavigationViewController.swift
//  ReSwiftConsumer
//
//  Created by brownsoo han on 2017. 11. 2..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

open class StateNavigationViewController<ReState>: UINavigationController where ReState: StateType {
    
    open var interactor: RePageInteractor<ReState>?
    
    open var pageStore: Store<ReState>? {
        return interactor?.pageStore ?? nil
    }
    open var pageConsumer: StateConsumer<ReState>? {
        return interactor?.pageConsumer
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.bindState()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor?.unbindState()
    }
}

