//
//  BaseStateController.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 23/09/2020.
//

import Foundation

class BaseStateController {
    
    // An enum to keep track of the current state of our ViewModels and it's requests
    enum State: Equatable {
        case initial /// Called once the ViewModel loaded
        case loading /// Should be called whenever an API call excuted
        case error(error: Error?) /// Should be called when encounter an error
        case result /// Should be called to represent the results
        
        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.initial, .initial): return true
            case (.loading, .loading): return true
            case (.error, .error): return true
            case (.result, .result): return true
            default: return false
            }
        }
    }
    
    private(set) var state: State = .initial {
        didSet {
            refreshState()
        }
    }
    
    /// Callback which can be used to refresh the state
    var refreshState: () -> Void = {}
    
    func initialState() {
        state = .initial
    }
    
    func loadingState() {
        state = .loading
    }
    
    func errorState(_ error: Error?) {
        state = .error(error: error)
    }
    
    func resultState() {
        state = .result
    }
}
