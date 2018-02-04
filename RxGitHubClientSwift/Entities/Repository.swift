//
//  Repository.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Foundation

// Generated with quicktype
// For more options, try https://app.quicktype.io
struct Repository: Codable {
    let id: Int
    let name, fullName: String
    let owner: Owner
    let description: String?
    let fork: Bool
    let htmlUrl, createdAt, updatedAt, pushedAt: String
    let stargazersCount: Int
    let language: String?
    let forksCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
        case owner
        case description
        case fork
        case htmlUrl = "html_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case stargazersCount = "stargazers_count"
        case language
        case forksCount = "forks_count"
    }
}
