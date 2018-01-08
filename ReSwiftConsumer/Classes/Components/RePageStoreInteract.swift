//
//  RePageStoreInteract.swift
//  Nimble
//
//  Created by hyonsoo han on 2018. 1. 8..
//

import ReSwift

public protocol RePageStoreInteract {
    
    associatedtype PageStoreInteractStateType: StateType
    
    var pageStore: Store<PageStoreInteractStateType>? { get }
    var pageStoreSubscriber: RePageStoreSubscriber<PageStoreInteractStateType>? { get }
    var pageConsumer: StateConsumer<PageStoreInteractStateType> { get }
    
    func bindState()
    func unbindState()
}
