//
//  UIApplication.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 26/09/2020.
//

import UIKit

extension UIApplication {
    
    static var isUITestingEnabled: Bool {
        return ProcessInfo.processInfo.environment[Constants.UITesting.uiTestingRunning] == "0"
    }
}
