//
//  StateShared.swift
//  ReSwiftConsumer
//
//  Created by hyonsoo han on 2017. 11. 3..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import UIKit
import ReSwift

public protocol StateShared {
    
    associatedtype S: StateType where S: Equatable
    
    var sharedStore: Store<S>? { get }
    var sharedConsumer: StateConsumer<S>? { get }
}


