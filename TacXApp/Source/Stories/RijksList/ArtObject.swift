//
//  ArtObject.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 24/09/2020.
//

import Foundation

struct ArtObject: Codable {
    let id: String
    let objectNumber: String
    let title: String
    let longTitle: String?
    let principalOrFirstMaker: String?
    let headerImage: ArtHeaderImage?
    let webImage: ArtWebImage?
    let links: ArtLinks?
    
    /// For Collection Details API to fill in
    let description: String?
    let dating: ArtDate?
}

struct ArtHeaderImage: Codable {
    let url: String?
}

struct ArtWebImage: Codable {
    let url: String?
}

struct ArtLinks: Codable {
    let web: String?
}

struct ArtDate: Codable {
    let presentingDate: String?
}
