//
//  RepoDetailViewModel.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import RxSwift
import RxCocoa

protocol RepoDetailViewModelInputs {
    var urlChanged: PublishRelay<URL?> { get }
    var backButtonTapped: PublishRelay<Void> { get }
    var forwardButtonTapped: PublishRelay<Void> { get }
    var refreshButtonTapped: PublishRelay<Void> { get }
    var canGoBackState: BehaviorRelay<Bool> { get }
    var canGoForwardState: BehaviorRelay<Bool> { get }
    var isLoadingState: BehaviorRelay<Bool> { get }
    var progressRateChanged: BehaviorRelay<Double> { get }
}

protocol RepoDetailViewModelOutputs {
    var selectedRepoDidChange: Driver<URL?> { get }
    var isUrlValid: Driver<Bool> { get }
    var urlDidChange: Signal<URL?> { get }
    var back: Signal<Void> { get }
    var forward: Signal<Void> { get }
    var refresh: Signal<Void> { get }
    var canGoBack: Driver<Bool> { get }
    var canGoForward: Driver<Bool> { get }
    var isLoading: Driver<Bool> { get }
    var progressRateDidChange: Driver<Float> { get }
}

protocol RepoDetailViewModelType {
    var inputs: RepoDetailViewModelInputs { get }
    var outputs: RepoDetailViewModelOutputs { get }
}

class RepoDetailViewModel: RepoDetailViewModelType, RepoDetailViewModelInputs, RepoDetailViewModelOutputs {
    
    // MARK: - Type
    var inputs: RepoDetailViewModelInputs { return self }
    var outputs: RepoDetailViewModelOutputs { return self }
    
    // MARK: - Inputs
    let urlChanged: PublishRelay<URL?> = PublishRelay()
    let backButtonTapped: PublishRelay<Void> = PublishRelay()
    let forwardButtonTapped: PublishRelay<Void> = PublishRelay()
    let refreshButtonTapped: PublishRelay<Void> = PublishRelay()
    let canGoBackState: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let canGoForwardState: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let isLoadingState: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let progressRateChanged: BehaviorRelay<Double> = BehaviorRelay(value: 0.0)
    
    // MARK: - Private Relay
    
    // MARK: - Outputs
    let selectedRepoDidChange: Driver<URL?>
    let isUrlValid: Driver<Bool>
    let urlDidChange: Signal<URL?>
    let back: Signal<Void>
    let forward: Signal<Void>
    let refresh: Signal<Void>
    let canGoBack: Driver<Bool>
    let canGoForward: Driver<Bool>
    let isLoading: Driver<Bool>
    let progressRateDidChange: Driver<Float>
    
    private let repository: RepoRepositoryType
    private let disposeBag = DisposeBag()
    
    init(repository: RepoRepositoryType) {
        self.repository = repository
        
        self.selectedRepoDidChange = repository.selectedRepoDidChange
        self.isUrlValid = repository.isUrlValid
        
        self.urlDidChange = self.urlChanged.asSignal()
        
        self.canGoBack = self.canGoBackState.asDriver()
        self.canGoForward = self.canGoForwardState.asDriver()
        
        self.back = self.backButtonTapped.asSignal()
        self.forward = self.forwardButtonTapped.asSignal()
        self.refresh = self.refreshButtonTapped.asSignal()
        
        self.isLoading = self.isLoadingState.asDriver()
        self.progressRateDidChange = self.progressRateChanged.asDriver().map { Float($0) }
    }
}
