//
//  SearchReposResponse.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Foundation

// Generated with quicktype
// For more options, try https://app.quicktype.io
struct SearchReposResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
    
    init() {
        self.totalCount = 0
        self.incompleteResults = false
        self.items = []
    }
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
