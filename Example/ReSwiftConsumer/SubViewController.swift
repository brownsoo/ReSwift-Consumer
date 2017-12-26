//
//  SubViewController.swift
//  ReSwiftConsumer_Example
//
//  Created by brownsoo on 2017. 12. 25..
//  Copyright © 2017년 HansooLabs. All rights reserved.
//

import Foundation
import UIKit
import ReSwiftConsumer

class SubViewController: StateSharedViewController<MainPageState> {
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        sharedConsumer?.add(selector: {state in state.count}, consumer: onCountChanged)
        
        if let count = sharedStore?.state.count {
            onCountChanged(prev: nil, curr: count)
        }
    }
    
    @IBAction func onClickPlus(_ sender: UIButton) {
        sharedStore?.dispatch(MainActionIncreaseCount())
    }
    
    @IBAction func onClickMinus(_ sender: UIButton) {
        sharedStore?.dispatch(MainActionDecreaseCount())
    }
    
    private func onCountChanged(prev: Int?, curr: Int) {
        countLabel.text = "shared count: \(curr)"
    }
}

extension SubViewController: CreateStateSharedViaStoryboard {
    typealias SharedState = MainPageState
    static var storyboardName: String { return "Main" }
    static var storyboardIdentity: String { return "SubViewController"}
}
