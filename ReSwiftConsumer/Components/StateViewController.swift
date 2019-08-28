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

    @available(*, unavailable, renamed: "pageController")
    open var pageInteractor: RePageController<ReState>?
    
    open var pageController: RePageController<ReState>?
    
    open var pageStore: Store<ReState>? {
        return pageController?.pageStore
    }
    open var pageConsumer: StateConsumer<ReState> = StateConsumer<ReState>()

    open override func viewDidLoad() {
        super.viewDidLoad()
        // make subscription on PageStore
        DispatchQueue.main.async {
            self.pageController?.bindState()
        }
    }

    deinit {
        // unsubscription on PageStore
        if let interactor = pageController, interactor.sharedConsumers.isEmpty {
             interactor.unbindState()
        }
        self.pageController = nil
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageController?.addSharedConsumer(pageConsumer)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        pageController?.removeSharedConsumer(pageConsumer)
        super.viewWillDisappear(animated)
    }
}


