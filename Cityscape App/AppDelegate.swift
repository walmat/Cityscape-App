//
//  AppDelegate.swift
//  Cityscape App
//
//  Created by Matthew Wall on 10/2/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        return true
    }
}
