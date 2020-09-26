//
//  AppController.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 20/09/2020.
//

import UIKit

final class AppController {
    
    /// The application main window
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    /// Network requests Client
    let api = API()
    
    init() {

        /// Go to RijksList screen
        routeToRijksList()
    }
    
    /// Set window root to News view controller
    private func routeToRijksList() {
        
        /// initialize the view model with the API object
        let rijksListViewModel = RijksListViewModel(api: api)
        
        /// Inject the view model into the view controller
        let rijksListViewController = RijksListViewController.create(payload: rijksListViewModel)
        
        let navigationController = UINavigationController(rootViewController: rijksListViewController)
        navigationController.navigationBar.isTranslucent = false
        
        window.rootViewController = navigationController
    }
}

