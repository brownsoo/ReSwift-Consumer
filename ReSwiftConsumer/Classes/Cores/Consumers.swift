//
//  Consumers.swift
//  ReSwiftConsumer
//
//  Created by brownsoo on 2017. 12. 23..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation

public protocol Consumer {
    associatedtype State
    func consume(old: State?, new: State?) -> Void
}

open class TypedConsumer<S>: Consumer, Hashable {
    public typealias State = S
    private lazy var objectIdentifier = ObjectIdentifier(self)
    public var hashValue: Int {
        return self.objectIdentifier.hashValue
    }
    
    open func consume(old: S?, new: S?) {
    }
    
    public static func ==(left: TypedConsumer<S>, right: TypedConsumer<S>) -> Bool {
        return left.objectIdentifier == right.objectIdentifier
    }
}

/// Links a property selector of State with a observer to notify changes.
public class SelectiveConsumer<S, T: Equatable>: TypedConsumer<S> {

    typealias State = S

    let selector: (S?) -> T?
    let consumer: (S?, T?, T?) -> Void

    init(_ selector: @escaping (S?) -> T?,
         _ consumer: @escaping (S?, T?, T?) -> Void) {
        self.selector = selector
        self.consumer = consumer
    }

    override open func consume(old: S?, new: S?) {
        let oldValue: T?
        if old != nil {
            oldValue = selector(old!)
        } else {
            oldValue = nil
        }
        let newValue: T?
        if new != nil {
            newValue = selector(new!)
        } else {
            newValue = nil
        }

        if oldValue == nil && newValue == nil {
            return
        }
        if (oldValue == nil || newValue == nil) || oldValue != newValue {
            DispatchQueue.main.async {
                self.consumer(new, oldValue, newValue)
            }
        }
    }
}

/// Links a array property selector of State with a observer to notify changes.
public class SelectiveArrayConsumer<S, T: Equatable>: TypedConsumer<S> {

    typealias State = S

    let selector: (S?) -> [T]?
    let consumer: (S?, [T]?, [T]?) -> Void

    init(_ selector: @escaping (S?) -> [T]?,
         _ consumer: @escaping (S?, [T]?, [T]?) -> Void) {
        self.selector = selector
        self.consumer = consumer
    }

    override open func consume(old: S?, new: S?) {
        let oldValue: [T]?
        if old != nil {
            oldValue = selector(old!)
        } else {
            oldValue = nil
        }
        let newValue: [T]?
        if new != nil {
            newValue = selector(new!)
        } else {
            newValue = nil
        }

        if (oldValue == nil && newValue == nil) {
            return
        }

        if oldValue != nil && newValue != nil {
            if !oldValue!.elementsEqual(newValue!) {
                DispatchQueue.main.async {
                    self.consumer(new, oldValue, newValue)
                }
            }
        } else {
            DispatchQueue.main.async {
                self.consumer(new, oldValue, newValue)
            }
        }
    }
}


public class PredictConsumer<S, T: Any>: TypedConsumer<S> {

    typealias State = S

    let selector: (S?) -> T?
    let consumer: (S?, T?, T?) -> Void
    let predictor: (T?, T?) -> Bool

    init(_ selector: @escaping (S?) -> T?,
         _ consumer: @escaping (S?, T?, T?) -> Void,
         _ predictor: @escaping (T?, T?) -> Bool) {
        self.selector = selector
        self.consumer = consumer
        self.predictor = predictor
    }

    public override func consume(old: S?, new: S?) {
        let oldValue = selector(old)
        let newValue = selector(new)
        if !self.predictor(oldValue, newValue) {
            DispatchQueue.main.async { [weak self] in
                self?.consumer(new, oldValue, newValue)
            }
        }
    }
}
