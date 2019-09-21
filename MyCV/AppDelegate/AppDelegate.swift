//
//  AppDelegate.swift
//  MyCV
//
//  Created by Angel Aguilar on 9/7/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame:UIScreen.main.bounds)
        RootRouter().presentMyProfileScene(window: window!)
        return true
    }
}

