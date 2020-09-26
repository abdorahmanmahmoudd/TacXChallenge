//
//  RijksCollection.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 21/09/2020.
//

import Foundation

class RijksCollection: Codable {
    
    let count: Int
    let artObjects: [ArtObject]
    
    init(count: Int, artObjects: [ArtObject]) {
        self.count = count
        self.artObjects = artObjects
    }
}
