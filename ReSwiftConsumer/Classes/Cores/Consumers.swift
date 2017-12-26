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
    func consume(prev: State?, curr: State) -> Void
}

public class TypedConsumer<S>: Consumer {
    public typealias State = S
    public func consume(prev: S?, curr: S) {}
}

/// 상태에서 선택된 속성의 변화를 소비한다.
public class SelectiveConsumer<S : Equatable, T : Equatable>: TypedConsumer<S> {
    
    typealias State = S
    
    let selector: (S) -> T?
    let consumer: (S, T?, T?) -> Void
    
    init(_ selector: @escaping (S) -> T?,
         _ consumer: @escaping (S, T?, T?) -> Void) {
        self.selector = selector
        self.consumer = consumer
    }
    
    override public func consume(prev: S?, curr: S) {
        let prevValue: T?
        if prev != nil {
            prevValue = selector(prev!)
        } else {
            prevValue = nil
        }
        let currValue = selector(curr)
        
        if prevValue != currValue {
            DispatchQueue.main.async {
                self.consumer(curr, prevValue, currValue)
            }
        }
    }
}

/// 상태에서 선택된 배열 속성의 변화를 소비한다.
public class SelectiveArrayConsumer<S : Equatable, T : Equatable>: TypedConsumer<S> {
    
    typealias State = S
    
    let selector: (S) -> [T]?
    let consumer: (S, [T]?, [T]?) -> Void
    
    init(_ selector: @escaping (S) -> [T]?,
         _ consumer: @escaping (S, [T]?, [T]?) -> Void) {
        self.selector = selector
        self.consumer = consumer
    }
    
    override public func consume(prev: S?, curr: S) {
        let prevValue: [T]?
        if prev != nil {
            prevValue = selector(prev!)
        } else {
            prevValue = nil
        }
        let currValue = selector(curr)
        if (prevValue == nil && currValue == nil) {
            return
        }
        
        if prevValue != nil && currValue != nil {
            if !prevValue!.elementsEqual(currValue!) {
                DispatchQueue.main.async {
                    self.consumer(curr, prevValue, currValue)
                }
            }
        } else {
            DispatchQueue.main.async {
                self.consumer(curr, prevValue, currValue)
            }
        }
    }
}
