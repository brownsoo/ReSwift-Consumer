//
//  AppDelegate.swift
//  ReSwiftConsumer
//
//  Created by brownsoo on 12/21/2017.
//  Copyright (c) 2017 brownsoo. All rights reserved.
//

import UIKit
import ReSwift

let loggingMiddle: Middleware<Any> = { dispatch, getState in
    return { next in
        return { action in
            print("action: \(action)")
            return next(action)
        }
    }
}

let appStore = Store<AppState>(
    reducer: appReducer,
    state: nil,
    middleware: [loggingMiddle]
)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        appStore.dispatch(AppActionSetForeground(foreground: false))
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        appStore.dispatch(AppActionSetForeground(foreground: true))
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

