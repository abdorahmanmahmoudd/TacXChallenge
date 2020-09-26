//
//  AppDelegate.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 20/09/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// The application pivot class
    private lazy var appController = AppController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// Presenting the `AppController` main window
        let window = appController.window
        window.makeKeyAndVisible()

        return true
    }
}

