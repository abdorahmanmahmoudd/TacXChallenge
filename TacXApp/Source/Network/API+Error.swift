//
//  API+Error.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 20/09/2020.
//

import Foundation

extension API {
    
    enum Error: LocalizedError {

        case decodingError(Swift.Error)
        case networkError(Swift.Error)
        case httpErrorCode(Int)
        case invalidURL
        
        // Custom error codes so that we recognize it quicker
        var code: Int {
            switch self {
            case .decodingError:
                return -11001
            case .networkError:
                return -11002
            case .invalidURL:
                return -11004
            case .httpErrorCode(let code):
                return code
            }
        }
        
        var errorDescription: String? {
            
            let genericMessage = "\("GENERAL_ERROR_DESCRIPTION".localized)\(code)"
            
            switch self {
            case .decodingError:
                return genericMessage
                
            case .httpErrorCode:
                return genericMessage
                
            case let .networkError(error):
                if (error as NSError).domain == NSURLErrorDomain, (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    return (error as NSError).localizedDescription
                }
                return genericMessage
                
            case .invalidURL:
                return "INVALID_URL".localized
            }
        }
    }
}
