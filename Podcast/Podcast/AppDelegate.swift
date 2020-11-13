//
//  AppDelegate.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let homeModule = HomeModule()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        homeModule.start()
        window?.makeKeyAndVisible()
        return true
    }
}

