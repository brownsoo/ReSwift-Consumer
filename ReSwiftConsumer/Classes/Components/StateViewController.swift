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

open class StateViewController<S, I: RePageInteractor<S>> : UIViewController  {
    
    open var pageInteractor: I?
    
    open var pageStore: Store<S>? {
        return pageInteractor?.pageStore ?? nil
    }
    open var pageConsumer: StateConsumer<S>? {
        return pageInteractor?.pageConsumer
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageInteractor?.bindState()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pageInteractor?.unbindState()
    }
}


