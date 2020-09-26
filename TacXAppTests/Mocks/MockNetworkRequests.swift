//
//  MockNetworkRequests.swift
//  TacXAppTests
//
//  Created by Abdelrahman Ali on 25/09/2020.
//

import Foundation
import RxSwift
@testable import TacXApp

enum MockError: Error {
    case error
    case noData
    case decodingError
}

enum MockNetworkRequestsResponse {
    case success
    case error
}

final class MockNetworkRequests: NetworkRequests {

    /// Config for Succes or Failure
    private let responseType: MockNetworkRequestsResponse
    
    init(responseType: MockNetworkRequestsResponse) {
        self.responseType = responseType
    }
    
    func getRijksList(query: String, page: Int) -> Single<RijksCollection?> {
        switch responseType {
        case .success:
            return MockResponse(responseType: .success, api: .getRijksList).rijksListResponse()
            
        default:
            return MockResponse(responseType: .error, api: .getRijksList).rijksListResponse()
        }
    }
    
    func getArtDetails(collectionId: String) -> Single<ArtDetails?> {
        switch responseType {
        case .success:
            return MockResponse(responseType: .success, api: .getArtDetails).artDetailstResponse()
            
        default:
            return MockResponse(responseType: .error, api: .getArtDetails).artDetailstResponse()
        }
    }
}
