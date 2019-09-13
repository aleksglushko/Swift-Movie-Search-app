//
//  AppDelegate.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 06.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // create navigation contorller
    var navController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // create VC and set it as root
        let loginViewController = LoginViewController()
        self.navController = UINavigationController(rootViewController: loginViewController)
        self.navController.setNavigationBarHidden(true, animated: false)
        
        // set frame to window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.navController
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

