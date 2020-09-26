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
    
    /// Network requests
    let api = API()
    
    init() {

        /// Go to RijksList screen
        routeToRijksList()
        
        /// Setup the caching layer
        setupCache()
    }
    
    private func setupCache() {
        let cache = URLCache(memoryCapacity: Constants.cacheSizeMegabytes * 1024 * 1024,
                             diskCapacity: 0,
                             diskPath: nil)
        URLCache.shared = cache
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

