//
//  URLSession.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 20/09/2020.
//

import Foundation
import RxSwift

extension URLSession {

    enum URLErrorUnknown: Error {
        case unknown
        case nonHTTPResponse(response: URLResponse)
    }
    
    func response<T>(for request: URLRequest) -> Single<T> where T: Decodable {
        
        return Single<T>.create { (single) -> Disposable in
            
            let task = self.dataTask(with: request) { data, response, error in
                
                // Validate Response
                guard let response = response, let data = data else {
                    single(.error(error ?? URLErrorUnknown.unknown))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.error(URLErrorUnknown.nonHTTPResponse(response: response)))
                    return
                }
                
                guard (200 ..< 300) ~= httpResponse.statusCode, error == nil else {
                    return single(.error(API.Error.httpErrorCode(httpResponse.statusCode)))
                }
                
                // Decode data into a model
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let model = try decoder.decode(T.self, from: data)
                    single(.success(model))
                } catch {
                    single(.error(API.Error.decodingError(error)))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
