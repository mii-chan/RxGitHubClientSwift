//
//  AnyGitHubTarget.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Foundation
import Moya

struct AnyGitHubTarget: GitHubTargetType {
    
    private let target: GitHubTargetType
    
    init(_ target: GitHubTargetType) {
        self.target = target
    }
    
    var path: String {
        return target.path
    }
    
    var method: Moya.Method {
        return target.method
    }
    
    var sampleData: Data {
        return target.sampleData
    }
    
    var task: Task {
        return target.task
    }
    
    var headers: [String: String]? {
        return target.headers
    }
}
