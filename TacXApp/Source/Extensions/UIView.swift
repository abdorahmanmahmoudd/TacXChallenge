//
//  UIView.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 20/09/2020.
//

import UIKit

extension UIView {
    
    /// Helper method to activate constraints for a UIView
    @objc func activateConstraints(for view: UIView) {

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// Helper method to load view from nib files
    func loadNib() -> UIView? {

        guard let xib = Bundle.main.loadNibNamed(String(describing: self.classForCoder.self),
                                                 owner: self,
                                                 options: nil)?.first as? UIView else {
                return nil
        }
        
        return xib
    }
}
