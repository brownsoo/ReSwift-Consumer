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
        return pageInteractor?.pageStore
    }
    open var pageConsumer: StateConsumer<ReState> = StateConsumer<ReState>()

    open override func viewDidLoad() {
        super.viewDidLoad()
        // make subscription on PageStore
        DispatchQueue.main.async {
            self.pageInteractor?.bindState()
        }
    }

    deinit {
        // unsubscription on PageStore
        if let interactor = pageInteractor, interactor.sharedConsumers.isEmpty {
             interactor.unbindState()
        }
        self.pageInteractor = nil
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


