//
//  TestingAppDelegate.swift
//  PalringoPhotosTests
//
//  Created by Sabrina Tardio on 20/03/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import UIKit

@objc(TestingAppDelegate)
final class TestingAppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            self.window = UIWindow()
            let vc = UIViewController()
            vc.view.backgroundColor = .yellow
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()        
        return true
    }
}
