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

open class StateNavigationViewController<S, I: RePageInteractor<S>>: UINavigationController {
    
    open var interactor: I?
    open var pageStore: Store<S>? {
        return interactor?.pageStore ?? nil
    }
    open var pageConsumer: StateConsumer<S>? {
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

