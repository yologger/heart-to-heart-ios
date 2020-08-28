//
//  AppDelegate.swift
//  heart-to-heart
//
//  Created by Hyukjung Kwon on 24/08/2020.
//  Copyright © 2020 yologger. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var appCoordinator: AppCoordinator?
    let appDIContainer = AppDIContainer()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.appCoordinator = AppCoordinator()
        self.appCoordinator?.start()
        
        return true
    }
}

