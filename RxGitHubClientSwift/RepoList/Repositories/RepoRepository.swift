//
//  RepoRepository.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import RxSwift
import RxCocoa
import Moya
import RxMoya

protocol RepoRepositoryType {
    var isOnline: Driver<Bool> { get }
    var isLoading: Driver<Bool> { get }
    var reposDidChange: Driver<[Repository]> { get }
    var selectedRepoDidChange: Driver<URL?> { get }
    var isUrlValid: Driver<Bool> { get }
    
    func searchRepository(by q: String)
    func selectRepository(urlStr: String)
}

class RepoRepository: RepoRepositoryType {
    let isOnline: Driver<Bool>
    let isLoading: Driver<Bool>
    let reposDidChange: Driver<[Repository]>
    let selectedRepoDidChange: Driver<URL?>
    let isUrlValid: Driver<Bool>
    
    private let isOnlineRelay: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    private let isLoadingRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private let reposDidChangeRelay: BehaviorRelay<[Repository]> = BehaviorRelay(value: [])
    private let selectedRepoDidChangeRelay: BehaviorRelay<URL?> = BehaviorRelay(value: nil)
    private let isUrlValidRelay: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    private let gitHubService: GitHubService
    
    private let disposeBag = DisposeBag()
    
    init(gitHubService: GitHubService) {
        self.gitHubService = gitHubService
        
        self.isOnline = self.isOnlineRelay.asDriver()
        self.isLoading = self.isLoadingRelay.asDriver()
        self.reposDidChange = self.reposDidChangeRelay.asDriver()
        self.selectedRepoDidChange = self.selectedRepoDidChangeRelay.asDriver()
        self.isUrlValid = self.isUrlValidRelay.asDriver()
    }
    
    func searchRepository(by q: String) {
        guard !q.isEmpty else { return }
        
        guard InternetConnection.isOnline else {
            self.isOnlineRelay.accept(false)
            return
        }
        
        self.isLoadingRelay.accept(true)
        switch q.firstLetter {
        case "@":
            // List User Repos
            gitHubService.listUserRepos(userId: q.withNoFirstLetter)
                .asDriver(onErrorJustReturn: Result(value: []))
                .drive(onNext: { [weak self] result in
                    self?.isLoadingRelay.accept(false)
                    
                    switch result {
                    case .success(let repos):
                        self?.isOnlineRelay.accept(true)
                        self?.reposDidChangeRelay.accept(repos)
                    case .failure(.notConnectedToInternet):
                        self?.isOnlineRelay.accept(false)
                    default:
                        break
                    }
                }).disposed(by: disposeBag)
        default:
            // Search Repos
            gitHubService.search(byWord: q)
                .asDriver(onErrorJustReturn: Result(value: SearchReposResponse()))
                .drive(onNext: { [weak self] result in
                    self?.isLoadingRelay.accept(false)
                    
                    switch result {
                    case .success(let response):
                        self?.isOnlineRelay.accept(true)
                        self?.reposDidChangeRelay.accept(response.items)
                    case .failure(.notConnectedToInternet):
                        self?.isOnlineRelay.accept(false)
                    default:
                        break
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    func selectRepository(urlStr: String) {
        guard InternetConnection.isOnline else {
            self.isOnlineRelay.accept(false)
            return
        }
        
        guard let url = URL(string: urlStr), url.isValid else {
            self.selectedRepoDidChangeRelay.accept(nil)
            self.isUrlValidRelay.accept(false)
            return
        }
        
        self.selectedRepoDidChangeRelay.accept(url)
        self.isUrlValidRelay.accept(true)
    }
}
