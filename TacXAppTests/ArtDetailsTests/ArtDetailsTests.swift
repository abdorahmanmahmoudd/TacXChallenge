//
//  ArtDetailsTests.swift
//  TacXAppTests
//
//  Created by Abdelrahman Ali on 26/09/2020.
//

import XCTest
@testable import TacXApp

class ArtDetailsTests: XCTestCase {
    
    /// Returns `ArtDetailsViewModel` injected with `MockNetworkRequests`
    private func artDetailsViewModel(responseType: MockNetworkRequestsResponse) -> ArtDetailsViewModel? {
        
        let api = MockNetworkRequests(responseType: responseType)
        guard let artObject = MockedResponseData().mockedArtDetails().artObject else {
            return nil
        }

        return ArtDetailsViewModel(art: artObject, api: api)
    }

    func testArtDetailsReceived() {
        /// Given
        let viewModel = artDetailsViewModel(responseType: .success)
        
        /// Then
        viewModel?.refreshState = {
            switch viewModel?.state {
            case .result:
                /// Then
                XCTAssertNotNil(viewModel?.art.dating)
                XCTAssertNotNil(viewModel?.art.description)
            case .error:
                /// Then
                XCTAssert(false)
            default:
                break
            }
        }
        
        /// When
        viewModel?.getArtDetails()
    }

    func testArtDetailsError() {
        /// Given
        let viewModel = artDetailsViewModel(responseType: .error)
        
        /// Then
        viewModel?.refreshState = {
            switch viewModel?.state {
            case .result:
                /// Then
                XCTAssert(false)
            case .error:
                /// Then
                XCTAssert(true)
            default:
                break
            }
        }
        
        /// When
        viewModel?.getArtDetails()
    }
}
