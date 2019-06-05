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
    public let pageConsumer: StateConsumer<ReState> = StateConsumer<ReState>()

    open override func viewDidLoad() {
        super.viewDidLoad()
        // makes subscription on PageStore
        pageInteractor?.bindState()
    }

    deinit {
        // unsubscription on PageStore
        pageInteractor?.unbindState()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageInteractor?.addSharedConsumer(pageConsumer)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        pageInteractor?.removeSharedConsumer(pageConsumer)
        super.viewWillDisappear(animated)
    }
}

