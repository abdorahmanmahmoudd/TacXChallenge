//
//  RijksListTests.swift
//  TacXAppTests
//
//  Created by Abdelrahman Ali on 26/09/2020.
//

import XCTest
import RxSwift
import RxBlocking
@testable import TacXApp

class RijksListTests: XCTestCase {
    
    /// Returns `NewsViewModel` injected with `MockNetworkRequests`
    private func rijksListViewModel(responseType: MockNetworkRequestsResponse) -> RijksListViewModel {
        
        let api = MockNetworkRequests(responseType: responseType)
        return RijksListViewModel(api: api)
    }

    func testRijksListReceived() {
        /// Given
        let viewModel = rijksListViewModel(responseType: .success)
        
        /// Then
        viewModel.refreshState = {
            switch viewModel.state {
            case .result:
                /// Then
                XCTAssert(!viewModel.isEmpty())
            case .error:
                /// Then
                XCTAssert(false)
            default:
                break
            }
        }
        
        /// When
        viewModel.getRijksArts()
    }

    func testRijksListError() {
        /// Given
        let viewModel = rijksListViewModel(responseType: .error)
        
        /// Then
        viewModel.refreshState = {
            switch viewModel.state {
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
        viewModel.getRijksArts()
    }
    
    func testRijksListEmpty() {
        
        /// Given
        let viewModel = rijksListViewModel(responseType: .error)
        
        /// When
        viewModel.getRijksArts()
        
        /// Then
        XCTAssert(viewModel.isEmpty())
    }
    
    func testRijksListNextPage() {
        
        /// Given
        let viewModel = rijksListViewModel(responseType: .success)
        
        /// Then
        viewModel.refreshState = {
            switch viewModel.state {
            case .result:
                /// Then
                XCTAssert(!viewModel.isEmpty())
            case .error:
                /// Then
                XCTAssert(false)
            default:
                break
            }
        }
        
        /// When
        viewModel.getRijksArts()
        
        /// Then
        if viewModel.shouldGetNextPage(withCellIndex: 0) {
            viewModel.getNextPage()
        }
    }
    
    func testRefreshArts() {
        
        /// Given
        let viewModel = rijksListViewModel(responseType: .success)
        
        /// Then
        viewModel.refreshState = {
            switch viewModel.state {
            case .result:
                /// Then
                XCTAssert(!viewModel.isEmpty())
            case .error:
                /// Then
                XCTAssert(false)
            default:
                break
            }
        }
        
        /// When
        viewModel.refreshArts()
    }
    
    func testArtsItemAt() {
        
        /// Given
        let viewModel = rijksListViewModel(responseType: .success)
        
        /// Then
        viewModel.refreshState = {
            switch viewModel.state {
            case .result:
                /// Then
                XCTAssertNotNil(viewModel.item(at: IndexPath(row: 0, section: 0)))
            case .error:
                /// Then
                XCTAssert(false)
            default:
                break
            }
        }
        
        /// When
        viewModel.getRijksArts()
    }
}
