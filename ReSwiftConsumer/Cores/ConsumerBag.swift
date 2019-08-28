//
//  ConsumerBag.swift
//  ReSwiftConsumer
//
//  Created by brownsoo han on 2018. 5. 25..
//  Copyright © 2017년 HansooLabs. All rights reserved.



/// ConsumerBag collect consumers and treat that.
/// We maybe need to use this when we work with 'SharedState'.
public class ConsumerBag<S> {
    private var bag = Set<TypedConsumer<S>>()
    private var stateConsumer: StateConsumer<S>!
    
    public init(_ consumer: StateConsumer<S>) {
        self.stateConsumer = consumer
    }
    
    public func add(_ consumer: TypedConsumer<S>?) {
        guard let consumer = consumer else {
            return
        }
        bag.update(with: consumer)
        stateConsumer?.add(consumer)
    }
    public func remove(_ consumer: TypedConsumer<S>?) {
        guard let consumer = consumer else {
            return
        }
        bag.remove(consumer)
        stateConsumer?.remove(consumer)
    }
    public func removeAll() {
        for c in bag {
            stateConsumer?.remove(c)
        }
        bag.removeAll()
    }
}
