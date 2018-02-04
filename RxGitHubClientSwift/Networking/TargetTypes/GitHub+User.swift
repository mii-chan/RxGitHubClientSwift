//
//  GitHub+User.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Moya
import RxSwift

protocol GitHubUserServiceType {
    func listUserRepos(userId: String) -> Single<Result<[Repository], GitHubError>>
}

extension GitHub {
    enum User {
        case listRepos(userId: String)
    }
}

extension GitHub.User: GitHubTargetType {
    var numberOfReposPerRequest: Int {
        return 20
    }
    
    var path: String {
        switch self {
        case .listRepos(let userId):
            return "/users/\(userId)/repos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listRepos:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .listRepos:
            return TestResponse.stubData("\(type(of: self))_listRepos")
        }
    }
    
    var task: Task {
        switch self {
        case .listRepos:
            return .requestParameters(parameters: ["sort": "pushed"], encoding: URLEncoding.default)
        }
    }
}
