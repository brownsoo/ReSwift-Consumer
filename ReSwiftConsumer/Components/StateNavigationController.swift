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

    @available(*, unavailable, renamed: "pageController")
    open var pageInteractor: RePageController<ReState>?
    
    open var pageController: RePageController<ReState>?
    
    open var pageStore: Store<ReState>? {
        return pageController?.pageStore ?? nil
    }
    public let pageConsumer: StateConsumer<ReState> = StateConsumer<ReState>()

    open override func viewDidLoad() {
        super.viewDidLoad()
        // makes subscription on PageStore
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

