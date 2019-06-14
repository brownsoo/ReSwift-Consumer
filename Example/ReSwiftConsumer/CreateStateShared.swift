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
