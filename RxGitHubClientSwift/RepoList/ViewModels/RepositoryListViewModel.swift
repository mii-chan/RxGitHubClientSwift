//
//  RepoListViewModel.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import RxSwift
import RxCocoa

protocol RepoListViewModelInputs {
    var searchTextDidEnter: BehaviorRelay<String> { get }
    var refreshButtonTapped: PublishRelay<Void> { get }
    var searchButtonTapped: PublishRelay<Void> { get }
    var repositorySelected: PublishRelay<Repository> { get }
}

protocol RepoListViewModelOutputs {
    var isLoading: Driver<Bool> { get }
    var reposDidChange: Driver<[Repository]> { get }
    var selectedRepoDidChange: Driver<URL?> { get }
    var isOnline: Driver<Bool> { get }
    var isSearchBarShown: Driver<Bool> { get }
}

protocol RepoListViewModelType {
    var inputs: RepoListViewModelInputs { get }
    var outputs: RepoListViewModelOutputs { get }
}

class RepoListViewModel: RepoListViewModelType, RepoListViewModelInputs, RepoListViewModelOutputs {
    
    // MARK: - Type
    var inputs: RepoListViewModelInputs { return self }
    var outputs: RepoListViewModelOutputs { return self }
    
    // MARK: - Inputs
    let searchTextDidEnter: BehaviorRelay<String> = BehaviorRelay(value: "")
    let refreshButtonTapped: PublishRelay<Void> = PublishRelay()
    let searchButtonTapped: PublishRelay<Void> = PublishRelay()
    let repositorySelected: PublishRelay<Repository> = PublishRelay()
    
    // MARK: - Private Relay
    private let isSearchBarShownRelay: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    // MARK: - Outputs
    let isLoading: Driver<Bool>
    let reposDidChange: Driver<[Repository]>
    let selectedRepoDidChange: Driver<URL?>
    let isOnline: Driver<Bool>
    let isSearchBarShown: Driver<Bool>
    
    private let repository: RepoRepositoryType
    private let disposeBag = DisposeBag()
    
    init(repository: RepoRepositoryType) {
        self.repository = repository
        
        self.isLoading = repository.isLoading
        self.reposDidChange = repository.reposDidChange.skip(1)
        self.selectedRepoDidChange = repository.selectedRepoDidChange.skip(1)
        self.isOnline = repository.isOnline
        self.isSearchBarShown = self.isSearchBarShownRelay.asDriver()
        
        searchTextDidEnter
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] word in
                self?.repository.searchRepository(by: word)
            }).disposed(by: disposeBag)
        
        refreshButtonTapped
            .asSignal()
            .emit(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.repository.searchRepository(by: strongSelf.searchTextDidEnter.value)
            }).disposed(by: disposeBag)
        
        searchButtonTapped
            .asSignal()
            .emit(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                
                strongSelf.isSearchBarShownRelay.accept(!strongSelf.isSearchBarShownRelay.value)
            }).disposed(by: disposeBag)
        
        repositorySelected
            .asSignal()
            .emit(onNext: { [weak self] repository in
                self?.repository.selectRepository(urlStr: repository.htmlUrl)
            }).disposed(by: disposeBag)
    }
}
