//
//  GitHub+Repository.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Moya
import RxSwift

protocol GitHubRepoServiceType {
    func getTrendingRepos(byLanguage language: String) -> Single<Result<SearchReposResponse, GitHubError>>
    func search(byWord q: String) -> Single<Result<SearchReposResponse, GitHubError>>
}

extension GitHub {
    enum Repo {
        case getTrending(byLanguage: String)
        case search(byWord: String)
    }
}

extension GitHub.Repo: GitHubTargetType {
    var numberOfReposPerRequest: Int {
        return 20
    }
    
    var path: String {
        switch self {
        case .getTrending, .search:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTrending, .search:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getTrending:
            return TestResponse.stubData("\(type(of: self))_getTrending")
        case .search:
            return TestResponse.stubData("\(type(of: self))_search")
        }
    }
    
    var task: Task {
        switch self {
        case .getTrending(let language):
            return .requestParameters(parameters: ["q": "language:\(language)", "per_page": "\(numberOfReposPerRequest)", "sort": "stars", "order": "desc"], encoding: URLEncoding.default)
        case .search(let word):
            return .requestParameters(parameters: ["q": "\(word)", "per_page": "\(numberOfReposPerRequest)", "sort": "stars", "order": "desc"], encoding: URLEncoding.default)
        }
    }
}
