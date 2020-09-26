//
//  ArtDetailsViewController.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 24/09/2020.
//

import UIKit

final class ArtDetailsViewController: BaseViewController {
    
    /// `ArtDetailsViewModel`
    private var viewModel: ArtDetailsViewModel!
    
    /// Scroll view
    private var scrollView = UIScrollView()
    
    /// Art details view
    private var artDetailsView: ArtView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Style Navigation Item
        styleNavigationItem()

        /// Embed and constraint the scroll view
        configureScrollView()

        /// Embed and configure the `ArtDetailsView`
        configureArtDetailsView()
        
        /// Bind observables
        bindObservables()

        /// Fetch art details API call
        viewModel.getArtDetails()
    }
    
    
    /// Set navigation item style
    private func styleNavigationItem() {
        navigationController?.navigationBar.tintColor = UIColor.brown
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.activateConstraints(for: view)
        scrollView.isAccessibilityElement = false
        scrollView.backgroundColor = .white
    }
    
    
    private func configureArtDetailsView() {

        guard let artDetailsView = ArtView().loadNib() as? ArtView else {
            fatalError("Couldn't embed ArtView")
        }
        scrollView.addSubview(artDetailsView)
        artDetailsView.activateConstraints(for: scrollView)

        /// Set `ArtView` width to adjust the scroll view width
        artDetailsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        /// Fill `ArtView` initial data
        artDetailsView.configure(with: viewModel.art)

        self.artDetailsView = artDetailsView
    }
    
    private func bindObservables() {
        
        /// Set view model state change callback
        viewModel.refreshState = { [weak self] in
            
            guard let self = self else {
                return
            }
            
            switch self.viewModel.state {
                
            case .initial:
                debugPrint("initial ArtDetailsViewController")
                
            case .loading:
                debugPrint("loading ArtDetailsViewController")
                self.showLoadingIndicator(visible: true)
                
                
            case .error(let error):
                debugPrint("error \(String(describing: error))")
                self.showLoadingIndicator(visible: false)
                
                /// If there is an error then show error view with that error and try again button
                self.showError(with: "GENERAL_EMPTY_STATE_ERROR".localized, message: error?.localizedDescription, retry: {
                    self.viewModel.getArtDetails()
                })
                return
                
            case .result:
                debugPrint("result ArtDetailsViewController")
                self.showLoadingIndicator(visible: false)
                
                self.artDetailsView?.configure(with: self.viewModel.art)
            }
        }
    }
}

// MARK: Injectable
extension ArtDetailsViewController: Injectable {

    typealias Payload = ArtDetailsViewModel

    func inject(payload: ArtDetailsViewModel) {
        viewModel = payload
    }

    func assertInjection() {
        assert(viewModel != nil)
    }
}
