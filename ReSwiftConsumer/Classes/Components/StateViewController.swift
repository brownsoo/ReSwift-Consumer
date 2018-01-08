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

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageInteractor?.bindState()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pageInteractor?.unbindState()
    }
}


