//
//  StateViewController.swift
//  ReSwiftConsumer
//
//  Created by hyonsoo han on 2017. 10. 18..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

open class StateViewController<S, I: RePageInteractor<S>> : UIViewController  {
    
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


