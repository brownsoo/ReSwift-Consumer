//
//  CreateStateShared.swift
//  ReSwiftConsumer_Example
//
//  Created by hanhyonsoo on 2017. 12. 25..
//  Copyright © 2017년 CocoaPods. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftConsumer

/// create ViewController via storyboard.
public protocol CreateViaStoryboard {
    static var storyboardName: String { get }
    static var storyboardIdentity: String { get }
    static func newInstance() -> UIViewController
}

public extension CreateViaStoryboard {
    
    static func newInstance() -> UIViewController {
        let story = UIStoryboard(name: storyboardName, bundle: nil)
        return story.instantiateViewController(withIdentifier: storyboardIdentity)
    }
}

public protocol CreateStateShared {
    
    associatedtype SharedState: StateType where SharedState: Equatable
    
    static func newInstance() -> UIViewController
    static func newStateSharedInstance(store: Store<SharedState>,
                                       consumer: StateConsumer<SharedState>) -> StateSharedViewController<SharedState>?
}

public extension CreateStateShared {
    static func newStateSharedInstance(store: Store<SharedState>,
                                       consumer: StateConsumer<SharedState>) -> StateSharedViewController<SharedState>? {
        let vc = newInstance()
        guard let shared = vc as? StateSharedViewController<SharedState> else {
            return nil
        }
        shared.bind(store: store, consumer: consumer)
        return shared
    }
}


/// create ViewController via storyboard that contains shared state.
public protocol CreateStateSharedViaStoryboard: CreateViaStoryboard {
    
    associatedtype SharedState: StateType where SharedState: Equatable
    static func newStateSharedInstance(store: Store<SharedState>,
                                       consumer: StateConsumer<SharedState>) -> StateSharedViewController<SharedState>?
}

public extension CreateStateSharedViaStoryboard {
    
    static func newStateSharedInstance(store: Store<SharedState>,
                                       consumer: StateConsumer<SharedState>) -> StateSharedViewController<SharedState>? {
        let vc = newInstance()
        guard let shared = vc as? StateSharedViewController<SharedState> else {
            return nil
        }
        shared.bind(store: store, consumer: consumer)
        return shared
    }
}
