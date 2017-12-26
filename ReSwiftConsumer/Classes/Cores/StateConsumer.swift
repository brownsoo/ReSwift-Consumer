//
//  StateConsumer.swift
//  ReSwiftConsumer
//
//  Created by brownsoo on 2017. 12. 23..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation

/// Consumes various typed states
public class StateConsumer<S : Equatable>: Consumer {
    
    public typealias State = S
    
    private var previousState: S? = nil
    private var consumers = [TypedConsumer<State>]()
    
    public init() {}
    
    public init(initialState: S? = nil) {
        self.previousState = initialState
    }
    
    public func consume(newState: S) {
        consumers.forEach { con in
            con.consume(prev: previousState, curr: newState)
        }
        self.previousState = newState
    }
    
    public func consume(prev: S?, curr: S) {
        consumers.forEach { con in
            con.consume(prev: prev, curr: curr)
        }
    }
    
    public func add(_ consumer: TypedConsumer<S>){
        consumers.append(consumer)
    }
    
    public func removeAll(){
        consumers.removeAll()
    }
    
    // MARK: for single property
    
    public func add<T: Equatable>(selector: @escaping (S) -> T?,
                                  consumer: @escaping (S, T?) -> Void) {
        add(SelectiveConsumer(selector, { state,_,curr in consumer(state, curr)} ))
    }
    
    public func add<T: Equatable>(selector: @escaping (S) -> T?,
                                  consumer: @escaping (T?) -> Void) {
        add(SelectiveConsumer(selector, { _, _, curr in consumer(curr) }))
    }
    
    public func add<T: Equatable>(selector: @escaping (S) -> T?,
                                  consumer: @escaping (T?, T?) -> Void) {
        add(SelectiveConsumer(selector, { _,prev,curr in consumer(prev, curr)} ))
    }
    // current value is not null
    public func add<T: Equatable>(selector: @escaping (S) -> T?,
                                  consumer: @escaping (T?, T) -> Void) {
        add(SelectiveConsumer(selector, { _,prev,curr in
            if curr != nil {
                consumer(prev, curr!)
            }
        } ))
    }
    // current value is not null
    public func add<T: Equatable>(selector: @escaping (S) -> T?,
                                  consumer: @escaping (T) -> Void) {
        add(SelectiveConsumer(selector, { _,_,curr in
            if curr != nil {
                consumer(curr!)
            }
        } ))
    }
    
    // MARK: for Array
    
    public func add<T: Equatable>(selector: @escaping (S) -> [T]?,
                                  consumer: @escaping ([T]?, [T]?) -> Void) {
        add(SelectiveArrayConsumer(selector, { _,prev,curr in
            consumer(prev, curr)
        } ))
    }
    
    public func add<T: Equatable>(selector: @escaping (S) -> [T]?,
                                  consumer: @escaping ([T]?, [T]) -> Void) {
        add(SelectiveArrayConsumer(selector, { _,prev,curr in
            if curr != nil {
                consumer(prev, curr!)
            }
        } ))
    }
}
