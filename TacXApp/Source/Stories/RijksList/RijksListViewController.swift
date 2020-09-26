//
//  RijksListViewController.swift
//  TacXApp
//
//  Created by Abdelrahman Ali on 21/09/2020.
//

import UIKit
import RxSwift
import RxCocoa

final class RijksListViewController: BaseViewController {
    
    /// News listing table view
    private var artsTableView = UITableView()
    
    /// `RijksListViewModel`
    private var viewModel: RijksListViewModel!
    
    /// Refresh control
    private let refreshControl = UIRefreshControl()
    
    /// RxSwift
    private let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()

        /// Set navigation bar title
        styleNavigationItem()
        
        /// Configure news table view and add it
        view.addSubview(artsTableView)
        configureArtsTableView()
        
        /// Bind reactive observables
        bindObservables()
        
        /// Request arts list
        viewModel.getRijksArts()
    }
    
    /// Set navigation item style
    private func styleNavigationItem() {
        title = "RIJKS_LIST_TITLE".localized
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.brown, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }

    
    /// Configure News table view
    private func configureArtsTableView() {
        
        /// Set delegate, datasource and refresh control
        artsTableView.delegate = self
        artsTableView.dataSource = self
        artsTableView.refreshControl = refreshControl
        artsTableView.separatorStyle = .none
        
        /// Register the cell
        let artTeaserNib = UINib(nibName: ArtTeaserTableViewCell.identifier, bundle: nil)
        artsTableView.register(artTeaserNib, forCellReuseIdentifier: ArtTeaserTableViewCell.identifier)
        
        /// Activate constraints and set row height to Automatic Dimension
        artsTableView.activateConstraints(for: view)
        artsTableView.rowHeight = UITableView.automaticDimension
        artsTableView.estimatedRowHeight = 180
    }
    
    private func bindObservables() {
        
        /// Set view model state change callback
        viewModel.refreshState = { [weak self] in
            
            guard let self = self else {
                return
            }
            
            /// end refreshing anyways
            self.refreshControl.endRefreshing()
            
            switch self.viewModel.state {
                
            case .initial:
                debugPrint("initial RijksListViewController")
                
            case .loading:
                debugPrint("loading RijksListViewController")
                self.showLoadingIndicator(visible: true)
                
                
            case .error(let error):
                debugPrint("error \(String(describing: error))")
                self.showLoadingIndicator(visible: false)
                
                /// If there is an error then show error view with that error and try again button
                self.showError(with: "GENERAL_EMPTY_STATE_ERROR".localized, message: error?.localizedDescription, retry: {
                    self.viewModel.getRijksArts()
                })
                return
                
            case .result:
                debugPrint("result RijksListViewController")
                self.showLoadingIndicator(visible: false)
                
                /// If there is no results then show a message with a try again button
                if self.viewModel.isEmpty() {
                    
                    self.showError(with: "GENERAL_EMPTY_STATE_ERROR".localized, retry: {
                        self.viewModel.getRijksArts()
                    })
                    return
                }
                self.removeErrorView()
                self.artsTableView.reloadData()
            }
        }
        
        /// Bind Refresh control value changed event to refresh the content
        refreshControl.rx.controlEvent(.valueChanged)
            .asObservable()
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                
                guard let self = self else {
                    return
                }

                self.viewModel.refreshArts()
                
            }).disposed(by: disposeBag)
    }
    
    /// Open `ArtDetailsViewController` with selected ArtObject
    private func pushArtDetails(with indexPath: IndexPath) {

        let artDetailViewModel = ArtDetailsViewModel(art: viewModel.item(at: indexPath), api: viewModel.api)
        let artDetailsViewController = ArtDetailsViewController.create(payload: artDetailViewModel)
        navigationController?.pushViewController(artDetailsViewController, animated: true)
    }
}

// MARK: UITableViewDataSource
extension RijksListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtTeaserTableViewCell.identifier,
                                                       for: indexPath) as? ArtTeaserTableViewCell else {
            fatalError("Couldn't dequeue a cell!")
        }

        cell.configure(with: viewModel.item(at: indexPath))
        return cell
    }
}

// MARK: UITableViewDelegate
extension RijksListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /// Do not fetch next page during  specific UI tests
        #if DEBUG
        if UIApplication.isUITestingEnabled {
            return
        }
        #endif
        
        /// check if we should fetch the next page
        if viewModel.shouldGetNextPage(withCellIndex: indexPath.row) {
            viewModel.getNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushArtDetails(with: indexPath)
    }
}

// MARK: Accessibility
extension RijksListViewController {

    override func setAccessibilityIdentifiers(){
        super.setAccessibilityIdentifiers()
        artsTableView.accessibilityIdentifier = AccessibilityIdentifiers.rijksListTableView.rawValue
        artsTableView.isAccessibilityElement = false
    }
}

// MARK: Injectable
extension RijksListViewController: Injectable {

    typealias Payload = RijksListViewModel

    func inject(payload: RijksListViewModel) {
        viewModel = payload
    }

    func assertInjection() {
        assert(viewModel != nil)
    }
}
