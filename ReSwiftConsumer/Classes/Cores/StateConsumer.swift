//
//  StateConsumer.swift
//  ReSwiftConsumer
//
//  Created by brownsoo on 2017. 12. 23..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation

/// Links various type consumer
public class StateConsumer<S>: TypedConsumer<S> {
    
    public typealias State = S
    /// if true, the consumer will consume previous state when that is added into StateConsumer.
    /// Old argument of consumer must be nullable.
    /// default: false
    public var consumeInstantly: Bool = false
    
    private var previousState: S? = nil
    private var consumers = Set<TypedConsumer<State>>()
    
    public override init() {
    }

    public init(initialState: S? = nil) {
        self.previousState = initialState
    }
    
    public override func consume(new: S?) {
        consumers.forEach { con in
            con.consume(old: previousState, new: new)
        }
        self.previousState = new
    }
    
    public override func consume(old: S?, new: S?) {
        consumers.forEach { con in
            con.consume(old: old, new: new)
        }
    }
    
    @discardableResult
    public func add(_ consumer: TypedConsumer<S>) -> TypedConsumer<S> {
        consumers.update(with: consumer)
        if consumeInstantly {
            consumer.consume(old: nil, new: previousState)
        }
        return consumer
    }
    
    public func remove(_ consumer: TypedConsumer<S>) {
        consumers.remove(consumer)
    }
    
    public func removeAll() {
        consumers.removeAll()
    }
    
    // MARK: for single property
    
    /// add consumer for a state and a new value
    @discardableResult
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (S?, T?) -> Void) -> TypedConsumer<S> {
        return add(SelectiveConsumer(selector, { state, _, new in consumer(state, new) }))
    }

    /// add consumer for a state and a new value
    @discardableResult
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (S?, T) -> Void) -> TypedConsumer<S> {
        return add(SelectiveConsumer(selector, { state, _, new in
            if new != nil {
                consumer(state, new!)
            }
        }))
    }

    /// add consumer for a state and a new value
    @discardableResult
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (S, T?) -> Void) -> TypedConsumer<S> {
        return add(SelectiveConsumer(selector, { state, _, new in
            if state != nil {
                consumer(state!, new)
            }
        }))
    }

    /// add consumer for a state and a new value
    @discardableResult
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (S, T) -> Void) -> TypedConsumer<S> {
        return add(SelectiveConsumer(selector, { state, _, new in
            if state != nil && new != nil {
                consumer(state!, new!)
            }
        }))
    }
    
    /// add consumer for a new nullable value
    @discardableResult
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (T?) -> Void) -> TypedConsumer<S> {
        return add(SelectiveConsumer(selector, { _, _, new in consumer(new) }))
    }
    
    /// add consumer for a new value
    @discardableResult
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (T) -> Void) -> TypedConsumer<S> {
        return add(SelectiveConsumer(selector, { _, _, new in
            if new != nil {
                consumer(new!)
            }
        }))
    }
    
    /// add consumer for old and new value that are nullable
    @discardableResult
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (T?, T?) -> Void) -> TypedConsumer<S> {
        return add(SelectiveConsumer(selector, { _, old, new in consumer(old, new) }))
    }
    
    /// add consumer for old and new value that are not-null
    @discardableResult
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (T, T) -> Void) -> TypedConsumer<S> {
        return add(SelectiveConsumer(selector, { _, old, new in
            if old != nil && new != nil {
                consumer(old!, new!)
            }
        }))
    }
    
    /// add consumer for nullable old and not-null new value
    @discardableResult
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (T?, T) -> Void) -> TypedConsumer<S> {
        return add(SelectiveConsumer(selector, { _, old, new in
            if new != nil {
                consumer(old, new!)
            }
        }))
    }
    
    
    // MARK: for Array
    
    // Nullable new value
    @discardableResult
    public func add<T: Equatable>(_ selector: @escaping (S?) -> [T]?,
                                  _ consumer: @escaping ([T]?, [T]?) -> Void) -> TypedConsumer<S> {
        return add(SelectiveArrayConsumer(selector, { _, old, new in
            consumer(old, new!)
        }))
    }
    
    // observing Not nullable new value
    @discardableResult
    public func add<T: Equatable>(_ selector: @escaping (S?) -> [T]?,
                                  _ consumer: @escaping ([T]?, [T]) -> Void) -> TypedConsumer<S> {
        return add(SelectiveArrayConsumer(selector, { _, old, new in
            if new != nil {
                consumer(old, new!)
            }
        }))
    }
    
    // MARK: for predictor
    
    // observing Nullable new value
    @discardableResult
    public func add<T>(_ selector: @escaping (S?) -> T?,
                       _ consumer: @escaping (T?, T?) -> Void,
                       predict: @escaping (T?, T?) -> Bool) -> TypedConsumer<S> {
        return add(PredictConsumer(selector, { _, old, new in
            consumer(old, new)
        }, predict))
    }
    
    // observing Not nullable new value
    @discardableResult
    public func add<T>(_ selector: @escaping (S?) -> T?,
                       _ consumer: @escaping (T?, T) -> Void,
                       predict: @escaping (T?, T?) -> Bool) -> TypedConsumer<S> {
        return add(PredictConsumer(selector, { _, old, new in
            if new != nil {
                consumer(old, new!)
            }
        }, predict))
    }
    
}
