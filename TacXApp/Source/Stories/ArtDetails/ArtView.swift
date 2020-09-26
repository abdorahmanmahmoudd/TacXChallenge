//
//  ArtView.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 25/09/2020.
//

import UIKit
import Nuke

final class ArtView: UIView {
    
    @IBOutlet private weak var artImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artMakerLabel: UILabel!
    @IBOutlet private weak var artDescriptionLabel: UILabel!
    @IBOutlet private weak var artPresentingDateLabel: UILabel!
    
    /// Art URL
    private var artURL: URL? = nil
    
    /// Fill in the data
    func configure(with art: ArtObject) {
        
        if let urlString = art.webImage?.url, let url = URL(string: urlString) {
            Nuke.loadImage(with: url, into: artImageView)
        } else {
            artImageView.image = #imageLiteral(resourceName: "image-placeholder")
        }
        
        titleLabel.text = art.longTitle
        artMakerLabel.text = art.principalOrFirstMaker
        artDescriptionLabel.text = art.description
        artPresentingDateLabel.text = art.dating?.presentingDate
        
        if let urlString = art.links?.web, let url = URL(string: urlString) {
            artURL = url
        }
        
        /// Setup up identifiers for UI testing
        setAccessibilityIdentifiers()
    }
    
    
    @IBAction func gotoArtButtonTapped(_ sender: UIButton) {
        guard let url = artURL else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

// MARK: Accessibility
extension ArtView {
    func setAccessibilityIdentifiers() {
        titleLabel.accessibilityIdentifier = AccessibilityIdentifiers.detailsArtTitle.rawValue
        artMakerLabel.accessibilityIdentifier = AccessibilityIdentifiers.detailsArtMaker.rawValue
        artDescriptionLabel.accessibilityIdentifier = AccessibilityIdentifiers.detailsArtDescription.rawValue
        artPresentingDateLabel.accessibilityIdentifier = AccessibilityIdentifiers.detailsArtDate.rawValue
    }
}
