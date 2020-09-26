//
//  MockResponse.swift
//  TacXAppTests
//
//  Created by Abdelrahman Ali on 25/09/2020.
//

import RxSwift
@testable import TacXApp

enum APIName {
    case getRijksList
    case getArtDetails
}

class MockResponse {
    
    private let responseType: MockNetworkRequestsResponse
    private let api: APIName
    
    init(responseType: MockNetworkRequestsResponse, api: APIName) {
        self.responseType = responseType
        self.api = api
    }
    
    func rijksListResponse() -> Single<RijksCollection?> {
        
        return Single.create { single -> Disposable in
            
            switch self.responseType {
            case .error:
                debugPrint("TEST-LOG RESPONSE OBSERVABLE ERROR")
                single(.error(MockError.error))
                
            case .success:
                debugPrint("TEST-LOG RESPONSE OBSERVABLE SUCCESS")
                let rijksList = MockedResponseData().mockedRijksList()
                single(.success(rijksList))
            }
            
            return Disposables.create()
        }
    }
    
    func artDetailstResponse() -> Single<ArtDetails?> {
        
        return Single.create { single -> Disposable in
            
            switch self.responseType {
            case .error:
                debugPrint("TEST-LOG RESPONSE OBSERVABLE ERROR")
                single(.error(MockError.error))
                
            case .success:
                debugPrint("TEST-LOG RESPONSE OBSERVABLE SUCCESS")
                let art = MockedResponseData().mockedArtDetails()
                single(.success(art))
            }
            
            return Disposables.create()
        }
    }
}
