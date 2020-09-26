//
//  Constants.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 20/09/2020.
//
import UIKit

/// App Global constants
struct Constants {
    static let apiKey = "VUFCswM1"
    static let baseURL = "https://www.rijksmuseum.nl"
    static let cacheSizeMegabytes = 20

    struct RijksList {
        static let updateTimeInterval: Double = 5 * 60 /// 5 mins
        static let rijksListCacheKey: NSString = "RIJKS_LIST_CACHE_KEY"
    }
    
    struct UITesting {
        static let uiTestingRunning = "UI_TESTING_RUNNING_KEY"
    }
    
}
