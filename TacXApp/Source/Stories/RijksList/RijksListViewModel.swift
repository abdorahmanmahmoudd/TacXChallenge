//
//  RijksListViewModel.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 21/09/2020.
//

import Foundation
import RxSwift

final class RijksListViewModel: BaseStateController {

    /// Network requests
    let api: NetworkRequests
    
    /// RxSwift
    private let disposeBag = DisposeBag()
    
    /// News list
    private var artsList: [ArtObject] = []
    
    /// Current page number
    private var page = 1
    
    /// Total items
    private var totalItems = 0
    
    
    init(api: NetworkRequests) {
        self.api = api
    }
}

// MARK: APIs
extension RijksListViewModel {
    
    /// Get Arts List
    func getRijksArts(withQuery query: String = "Rembrandt", isRefreshing: Bool = false, isFetchingNextPage: Bool = false) {
        
        /// If not refreshing show loading indicator
        if !isRefreshing && !isFetchingNextPage {
            loadingState()
        }
        
        /// Execute the API call
        api.getRijksList(query: query, page: page).subscribe(onSuccess: { [weak self] response in
            
            guard let self = self else {
                return
            }
            
            /// If refreshing, remove the old content
            if isRefreshing {
                self.artsList.removeAll()
            }
            
            self.artsList.append(contentsOf: response?.artObjects ?? [])
            self.totalItems = response?.count ?? 0
            
            /// Call the result state backback
            self.resultState()
            
        }) { [weak self] error in
            
            guard let self = self else {
                return
            }
            
            self.errorState(error)

        }.disposed(by: disposeBag)
    }
     
     /// Get next news page
     func getNextPage() {
         page += 1
         getRijksArts(isFetchingNextPage: true)
     }
     
     /// Refresh the content
     func refreshArts() {
         page = 1
         getRijksArts(isRefreshing: true)
     }
}


// MARK: Datasource
extension RijksListViewModel {

    func numberOfRows() -> Int {
        return artsList.count
    }
    
    func item(at indexPath: IndexPath) -> ArtObject {
        return artsList[indexPath.row]
    }
    
    func isEmpty() -> Bool {
        return artsList.count == 0
    }

    /// Returns whether you should get the next page or not
    func shouldGetNextPage(withCellIndex index: Int) -> Bool{
        
        /// if reached the last cell && not reached the total number of items then reload next page
        if index == artsList.count - 1 {
            if totalItems > artsList.count {
                return true
            }
        }
        return false
    }
}
