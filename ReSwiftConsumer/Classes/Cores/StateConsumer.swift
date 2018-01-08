//
//  StateConsumer.swift
//  ReSwiftConsumer
//
//  Created by brownsoo on 2017. 12. 23..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation

/// Links various type consumer
public class StateConsumer<S>: Consumer {
    
    public typealias State = S
    
    private var previousState: S? = nil
    private var consumers = [TypedConsumer<State>]()
    
    public init() {}
    
    public init(initialState: S? = nil) {
        self.previousState = initialState
    }
    
    public func consume(newState: S) {
        consumers.forEach { con in
            con.consume(old: previousState, new: newState)
        }
        self.previousState = newState
    }
    
    public func consume(old: S?, new: S?) {
        consumers.forEach { con in
            con.consume(old: old, new: new)
        }
    }
    
    public func add(_ consumer: TypedConsumer<S>){
        consumers.append(consumer)
    }
    
    public func removeAll(){
        consumers.removeAll()
    }
    
    // MARK: for single property
    
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (S?, T?) -> Void) {
        add(SelectiveConsumer(selector, { state, _, new in consumer(state, new)} ))
    }
    // new value is nullable
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (T?) -> Void) {
        add(SelectiveConsumer(selector, { _, _, new in consumer(new) }))
    }
    // new value is nullable
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (T?, T?) -> Void) {
        add(SelectiveConsumer(selector, { _, old, new in consumer(old, new)} ))
    }
    // new value is not nullable
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (T?, T) -> Void) {
        add(SelectiveConsumer(selector, { _, old, new in
            if new != nil {
                consumer(old, new!)
            }
        } ))
    }
    // new value is not nullable
    public func add<T: Equatable>(_ selector: @escaping (S?) -> T?,
                                  _ consumer: @escaping (T) -> Void) {
        add(SelectiveConsumer(selector, { _,_,new in
            if new != nil {
                consumer(new!)
            }
        } ))
    }
    
    // MARK: for Array
    
    // Nullable new value
    public func add<T: Equatable>(_ selector: @escaping (S?) -> [T]?,
                                  _ consumer: @escaping ([T]?, [T]?) -> Void) {
        add(SelectiveArrayConsumer(selector, { _,old,new in
            consumer(old, new!)
        } ))
    }
    
    // observing Not nullable new value
    public func add<T: Equatable>(_ selector: @escaping (S?) -> [T]?,
                                  _ consumer: @escaping ([T]?, [T]) -> Void) {
        add(SelectiveArrayConsumer(selector, { _,old,new in
            if new != nil {
                consumer(old, new!)
            }
        } ))
    }
    
    // MARK: for predictor
    
    // observing Nullable new value
    public func add<T>(_ selector: @escaping (S?) -> T?,
                       _ consumer: @escaping (T?, T?) -> Void,
                       predictor: @escaping (T, T) -> Bool) {
        add(PredictConsumer(selector, { _, old, new in
            consumer(old, new)
        }, predictor))
    }
    
    // observing Not nullable new value
    public func add<T>(_ selector: @escaping (S?) -> T?,
                       _ consumer: @escaping (T?, T) -> Void,
                       predictor: @escaping (T, T) -> Bool) {
        add(PredictConsumer(selector, { _, old, new in
            if new != nil { consumer(old, new!) }
        }, predictor))
    }
    
}
