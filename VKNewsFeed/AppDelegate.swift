//
//  AppDelegate.swift
//  VKNewsFeed
//
//  Created by Serg on 04/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import UIKit
import VK_ios_sdk


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate { //AuthServiceDelegate

    var window: UIWindow?
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appCoordinator: Coordinator = DependenceProvider.resolve()
        window = appCoordinator.prepareWindow()
      
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true 
    }
}

