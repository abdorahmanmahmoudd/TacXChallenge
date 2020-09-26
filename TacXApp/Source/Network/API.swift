//
//  API.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 20/09/2020.
//
import Foundation
import RxSwift

// MARK: - NetworkRequests
protocol NetworkRequests {
    func getRijksList(query: String, page: Int) -> Single<RijksCollection?>
    func getArtDetails(collectionId: String) -> Single<ArtDetails?>
}
   

//self?.cache.setObject(result as NSArray, forKey: videoId as NSString)

// MARK: Rijks List
final class API: NetworkRequests {

    /// cache
    private let rijksListCache: NSCache<NSString, RijksCollection> = NSCache<NSString, RijksCollection>()
    
    /// To track last RijksList API update
    private var lastUpdate: Date?
    
    /// Indicates if update is needed
    private var needsUpdate: Bool {
        guard let lastUpdate = lastUpdate else {
            return true
        }
        return abs(lastUpdate.timeIntervalSinceNow) > Constants.RijksList.updateTimeInterval
    }
    
    func getRijksList(query: String, page: Int) -> Single<RijksCollection?> {
        
        /// Check if it needs update && there is a cached response
        if !needsUpdate,
            let cachedList = rijksListCache.object(forKey: "\(Constants.RijksList.rijksListCacheKey)_\(page)" as NSString) {

            return .just(cachedList)
        }
        
        guard let fullURL = URL(string: "\(Constants.baseURL)/api/nl/collection?key=\(Constants.apiKey)&q=\(query)&p=\(page)") else {
            return .error(API.Error.invalidURL)
        }
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        
        return URLSession.shared.response(for: request)
            .observeOn(MainScheduler.asyncInstance)
            .do(onSuccess: { [weak self] response in
                
                guard let self = self,
                    let rijksCollection = response else {
                        return
                }
                
                self.lastUpdate = Date()
                self.rijksListCache.setObject(rijksCollection, forKey: "\(Constants.RijksList.rijksListCacheKey)_\(page)" as NSString)
            })
    }
}

// MARK: - Art Details
extension API {
    func getArtDetails(collectionId: String) -> Single<ArtDetails?> {
        
        guard let fullURL = URL(string: "\(Constants.baseURL)/api/nl/collection/\(collectionId)?key=\(Constants.apiKey)") else {
            return .error(API.Error.invalidURL)
        }
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        
        return URLSession.shared.response(for: request).observeOn(MainScheduler.asyncInstance)
    }
}
