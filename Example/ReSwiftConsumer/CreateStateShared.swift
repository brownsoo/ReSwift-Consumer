//
//  CreateStateShared.swift
//  ReSwiftConsumer_Example
//
//  Created by brownsoo on 2017. 12. 25..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftConsumer

/// create ViewController via storyboard.
public protocol CreateViaStoryboard {
    static var storyboardName: String { get }
    static var storyboardIdentity: String { get }
    static func newInstance<T>() -> T where T: UIViewController
}

public extension CreateViaStoryboard {
    
    static func newInstance<T>() -> T where T: UIViewController {
        let story = UIStoryboard(name: storyboardName, bundle: nil)
        return story.instantiateViewController(withIdentifier: storyboardIdentity) as! T
    }
}

public protocol CreateStateShared {
    
    associatedtype SharedState: StateType where SharedState: Equatable
    
    static func newInstance<T>() -> T where T: UIViewController
    static func newStateSharedInstance<T>(
        store: Store<SharedState>,
        consumer: StateConsumer<SharedState>) -> T? where T: StateSharedViewController<SharedState>
}

public extension CreateStateShared {
    static func newInstance<T>() -> T where T: UIViewController {
        return T()
    }
    static func newStateSharedInstance<T>(
        store: Store<SharedState>,
        consumer: StateConsumer<SharedState>) -> T? where T: StateSharedViewController<SharedState> {
        let vc = newInstance()
        guard let shared = vc as? T else {
            return nil
        }
        shared.bind(store: store, consumer: consumer)
        return shared
    }
}


/// create ViewController via storyboard that contains shared state.
public protocol CreateStateSharedViaStoryboard: CreateViaStoryboard {
    
    associatedtype SharedState: StateType where SharedState: Equatable
    static func newStateSharedInstance<T>(
        store: Store<SharedState>,
        consumer: StateConsumer<SharedState>) -> T? where T: StateSharedViewController<SharedState>
}

public extension CreateStateSharedViaStoryboard {
    
    static func newStateSharedInstance<T>(
        store: Store<SharedState>,
        consumer: StateConsumer<SharedState>) -> T? where T: StateSharedViewController<SharedState> {
        let vc = newInstance()
        guard let shared = vc as? T else {
            return nil
        }
        shared.bind(store: store, consumer: consumer)
        return shared
    }
}
