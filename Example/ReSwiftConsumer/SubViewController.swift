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

class SubViewController: StateSharedViewController<MainState> {
    
    @IBOutlet weak var countLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        pageConsumer.consumeInstantly = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Add new consumer created instantly
        pageConsumer.add({state in state?.count}, onCountChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pageConsumer.removeAll()
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
    typealias SharedState = MainState
    static var storyboardName: String { return "Main" }
    static var storyboardIdentity: String { return "SubViewController"}
}
