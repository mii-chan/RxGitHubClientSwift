//
//  RepoListViewController.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RepoListViewController: UIViewController {
    
    private let rootView: RepoListView
    private let searchButton: UIBarButtonItem
    
    private let viewModel: RepoListViewModelType
    private let disposeBag = DisposeBag()
    
    weak var detailVC: RepoDetailViewController!
    
    init(viewModel: RepoListViewModelType) {
        self.rootView = RepoListView()
        self.viewModel = viewModel
        self.searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        self.view = self.rootView
        self.title = "Top 20 Repositories"
        self.navigationItem.leftBarButtonItem = self.searchButton
        // MARK: - Initial Value
        self.rootView.searchBar.textField?.text = "Swift"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Inputs
        self.rootView.searchBar.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
            .drive(self.viewModel.inputs.searchTextDidEnter)
            .disposed(by: disposeBag)
        
        self.rootView.refreshButtonOutlet.rx.tap
            .asSignal()
            .emit(to: self.viewModel.inputs.refreshButtonTapped)
            .disposed(by: disposeBag)
        
        self.searchButton.rx.tap
            .asSignal()
            .emit(to: self.viewModel.inputs.searchButtonTapped)
            .disposed(by: disposeBag)
        
        self.rootView.tableview.rx
            .modelSelected(Repository.self)
            .asSignal()
            .emit(to: self.viewModel.inputs.repositorySelected)
            .disposed(by: disposeBag)
        
        // MARK: - Outputs
        // MARK: - SearchBar
        self.viewModel.outputs.isSearchBarShown
            .drive(onNext: { [weak self] bool in
                UIView.animate(withDuration: 0.25) {
                    self?.rootView.searchBar.isHidden = bool
                }
            })
            .disposed(by: disposeBag)
        
        // MARK: - Loading
        self.viewModel.outputs.isLoading
            .drive(self.rootView.activityIndicatorOutlet.rx.isAnimating)
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.isLoading
            .drive(self.rootView.tableview.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.isLoading
            .drive(self.rootView.errorViewOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        // MARK: - TableView
        self.viewModel.outputs.reposDidChange
            .map { $0.isEmpty }
            .drive(self.rootView.tableview.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.reposDidChange
            .map { !$0.isEmpty }
            .drive(onNext: { [weak self] shouldHidden in
                self?.rootView.errorViewOutlet.isHidden = shouldHidden
                self?.rootView.errorStackViewOutlet.isHidden = shouldHidden
                self?.rootView.errorMessageOutlet.text = "No Repository Found"
                self?.rootView.refreshButtonOutlet.isHidden = true
            })
            .disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Repository>>(
            configureCell: { dataSource, tableView, indexPath, repo in
                return RepositoryCardCell.dequeue(from: tableView, repo: repo)
        }
        )
        
        self.viewModel.outputs.reposDidChange
            .map { repos in [SectionModel(model: "", items: repos)] }
            .drive(self.rootView.tableview.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.selectedRepoDidChange
            .drive(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                
                strongSelf.splitViewController?.showDetailViewController(UINavigationController(rootViewController: strongSelf.detailVC), sender: nil)
            }).disposed(by: disposeBag)
        
        // MARK: - Internet Connection
        self.viewModel.outputs.isOnline
            .filter { !$0 }
            .drive(onNext: { [weak self] isOnline in
                self?.rootView.errorViewOutlet.isHidden = isOnline
                self?.rootView.errorStackViewOutlet.isHidden = isOnline
                self?.rootView.errorMessageOutlet.text = "Your device seems to be offline"
                self?.rootView.refreshButtonOutlet.isHidden = isOnline
            })
            .disposed(by: disposeBag)
    }
}
