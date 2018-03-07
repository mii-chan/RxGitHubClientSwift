//
//  GitHubService.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Foundation
import RxSwift
import Moya
import RxMoya

protocol GitHubServiceType: GitHubRepoServiceType, GitHubUserServiceType {}

class GitHubService: GitHubServiceType {
    
    private let provider: MoyaProvider<AnyGitHubTarget>
    
    init(provider: MoyaProvider<AnyGitHubTarget>) {
        self.provider = provider
    }
    
    private func emitSingle<D: Decodable>(_ target: GitHubTargetType, responseType: D.Type) -> Single<Result<D, GitHubError>> {
        return provider.rx.request(AnyGitHubTarget(target))
            .filterSuccessfulStatusCodes()
            .map(D.self)
            .map { Result(value: $0) }
            .catchError { error in
                return Single<Result<D, GitHubError>>.create { single in
                    if let moyaError = error as? MoyaError {
                        switch moyaError {
                        case .objectMapping(let error, _):
                            single(.error(GitHubError.couldNotParseJson(error)))
                        case .underlying(let error):
                            if (error.0 as NSError).code == NSURLErrorNotConnectedToInternet {
                                single(.success(Result(error: GitHubError.notConnectedToInternet)))
                            }
                            if let response = error.1, let apiError = try? response.map(GitHubAPIClientError.self) {
                                single(.error(GitHubError.apiError(apiError)))
                            }
                        default:
                            break
                        }
                    }
                    
                    single(.error(error))
                    
                    return Disposables.create()
                }
            }
            .log()
        
    }
}

extension GitHubService: GitHubRepoServiceType {
    func getTrendingRepos(byLanguage language: String) -> PrimitiveSequence<SingleTrait, Result<SearchReposResponse, GitHubError>> {
        return self.emitSingle(GitHub.Repo.getTrending(byLanguage: language), responseType: SearchReposResponse.self)
    }
    
    func search(byWord q: String) -> PrimitiveSequence<SingleTrait, Result<SearchReposResponse, GitHubError>> {
        return self.emitSingle(GitHub.Repo.search(byWord: q), responseType: SearchReposResponse.self)
    }
}

extension GitHubService: GitHubUserServiceType {
    func listUserRepos(userId: String) -> PrimitiveSequence<SingleTrait, Result<[Repository], GitHubError>> {
        return self.emitSingle(GitHub.User.listRepos(userId: userId), responseType: [Repository].self)
            .map { result in
                switch result {
                case .success(let repos):
                    return Result(value: repos.sorted {$0.stargazersCount > $1.stargazersCount })
                default:
                    return result
                }
        }
    }
}
