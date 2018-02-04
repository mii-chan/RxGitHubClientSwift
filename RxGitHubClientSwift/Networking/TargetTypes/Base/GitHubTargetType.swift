//
//  GitHubTargetType.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Foundation
import Moya

protocol GitHubTargetType: TargetType {}

extension GitHubTargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var validate: Bool {
        return true
    }
    
    var headers: [String: String]? {
        return nil
    }
}
