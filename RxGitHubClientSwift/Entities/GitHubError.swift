//
//  GitHubError.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Foundation
import Moya

enum GitHubError: Swift.Error {
    case notConnectedToInternet
    case couldNotParseJson(Error)
    case apiError(GitHubAPIClientError)
}
