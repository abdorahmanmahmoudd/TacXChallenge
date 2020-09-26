//
//  ArtDetailsViewModel.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 24/09/2020.
//

import Foundation
import RxSwift

final class ArtDetailsViewModel: BaseStateController {
    
    /// Network requests
    private let api: NetworkRequests
    
    /// RxSwift
    private let disposeBag = DisposeBag()
    
    /// Art details
    var art: ArtObject
    
    init(art: ArtObject, api: NetworkRequests) {
        
        self.art = art
        self.api = api
        
        super.init()
    }
}

// MARK: APIs
extension ArtDetailsViewModel {
    
    /// Get Art dertails
    func getArtDetails() {

        loadingState()
        
        /// Execute the API call
        api.getArtDetails(collectionId: art.objectNumber).subscribe(onSuccess: { [weak self] response in
            
            guard let self = self,
                let art = response?.artObject else {
                return
            }

            self.art = art
            
            /// Call the result state backback
            self.resultState()
            
        }) { [weak self] error in
            
            guard let self = self else {
                return
            }
            
            self.errorState(error)

        }.disposed(by: disposeBag)
    }
}
