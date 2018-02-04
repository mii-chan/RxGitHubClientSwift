//
//  Owner.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Foundation

// Generated with quicktype
// For more options, try https://app.quicktype.io
struct Owner: Codable {
    let login: String
    let id: Int
    let avatarURL, gravatarID, url, receivedEventsURL: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case receivedEventsURL = "received_events_url"
        case type
    }
}
