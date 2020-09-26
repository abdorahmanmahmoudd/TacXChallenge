//
//  ArtTeaserTableViewCell.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 23/09/2020.
//

import UIKit
import Nuke

final class ArtTeaserTableViewCell: UITableViewCell {
    
    /// the identifier should match the class name
    static let identifier = "ArtTeaserTableViewCell"
    
    @IBOutlet private weak var artImageView: UIImageView!
    @IBOutlet private weak var artTitle: UILabel!
    @IBOutlet private weak var artMakerLabel: UILabel!
    
    /// Fill the view data fields
    func configure(with art: ArtObject) {
        
        artTitle.text = art.title
        artMakerLabel.text = art.principalOrFirstMaker
        
        if let urlString = art.headerImage?.url, let imageURL = URL(string: urlString) {
            Nuke.loadImage(with: imageURL, into: artImageView)
        } else {
            artImageView.image = #imageLiteral(resourceName: "image-placeholder")
        }
    }
    
}
