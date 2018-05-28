//
//  StateShared.swift
//  ReSwiftConsumer
//
//  Created by brownsoo han on 2017. 11. 3..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import UIKit
import ReSwift

public protocol StateShared {
    
    associatedtype StateSharedType: StateType
    
    var sharedStore: Store<StateSharedType>? { get }
    var sharedConsumer: StateConsumer<StateSharedType>? { get }
    func bind(store: Store<StateSharedType>, consumer: StateConsumer<StateSharedType>)
}
