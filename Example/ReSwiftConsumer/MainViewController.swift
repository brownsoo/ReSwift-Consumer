//
//  ViewController.swift
//  ReSwiftConsumer
//
//  Created by brownsoo on 12/21/2017.
//  Copyright (c) 2017 brownsoo. All rights reserved.
//

import UIKit
import ReSwiftConsumer

class MainViewController: StateViewController<MainPageState, MainInteractor> {

    @IBOutlet weak var countLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = MainInteractor()
        pageConsumer?.add(selector: {state in state.count}, consumer: onCountChanged)
        
    }
    
    @IBAction func onClickPlus(_ sender: UIButton) {
        pageStore?.dispatch(MainActionIncreaseCount())
    }
    
    @IBAction func onClickMinus(_ sender: UIButton) {
        pageStore?.dispatch(MainActionDecreaseCount())
    }
    
    @IBAction func onClickOpenShared(_ sender: UIButton) {
        let controller = SubViewController.newStateSharedInstance(store: pageStore!, consumer: pageConsumer!)
        self.present(controller!, animated: true, completion: nil)
    }
    
    private func onCountChanged(prev: Int?, curr: Int) {
        countLb.text = "count: \(curr)"
    }
    
}

