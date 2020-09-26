//
//  MockedResponseData.swift
//  TacXAppTests
//
//  Created by Abdelrahman Ali on 26/09/2020.
//

import Foundation
import RxSwift
@testable import TacXApp

class MockedResponseData {}

// MARK: RijksList Mocked Responses
extension MockedResponseData {

    func mockedRijksList() -> RijksCollection? {
        return RijksCollection(count: 1, artObjects: [mockedArtObject()])
    }
}

// MARK: ArtDetails Mocked Responses
extension MockedResponseData {
    
    func mockedArtDetails() -> ArtDetails {
        return ArtDetails(artObject: mockedArtObject())
    }
    
    func mockedArtObject() -> ArtObject {
        
        let artHeaderImage = ArtHeaderImage(url: "https://lh3.googleusercontent.com/WKIxue0nAIOYj00nGVoO4DTP9rU2na0qat5eoIuQTf6Fbp4mHHm-wbCes1Oo6K_6IdMl6Z_OCjGW_juCCf_jvQqaKw=s0")
        
        let artWebImage = ArtWebImage(url: "https://lh3.googleusercontent.com/7qzT0pbclLB7y3fdS1GxzMnV7m3gD3gWnhlquhFaJSn6gNOvMmTUAX3wVlTzhMXIs8kM9IH8AsjHNVTs8em3XQI6uMY=s0")
        
        let artLinks = ArtLinks(web: "https://test.com")
        
        let artDate = ArtDate(presentingDate: "25/9/2020")
        
        let art = ArtObject(id: "nl-SK-A-4691",
                            objectNumber: "SK-A-4691",
                            title: "title",
                            longTitle: "long title",
                            principalOrFirstMaker: "Abdo",
                            headerImage: artHeaderImage,
                            webImage: artWebImage,
                            links: artLinks,
                            description: "very long description",
                            dating: artDate)
        
        return art
    }
}
