//
//  GitHubAPIClientError.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Foundation

// Generated with quicktype
// For more options, try https://app.quicktype.io
struct GitHubAPIClientError: Codable, Swift.Error {
    let message: String
    let errors: [Error]
    
    struct Error: Codable {
        let resource, field, code: String
    }
}
