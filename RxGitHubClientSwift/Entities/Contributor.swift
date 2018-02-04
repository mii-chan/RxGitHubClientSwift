//
//  Contributor.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Foundation

// Generated with quicktype
// For more options, try https://app.quicktype.io
struct Contributor: Codable {
    let login: String
    let id: Int
    let avatarURL, gravatarID, url, htmlURL: String
    let followersURL, followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL, eventsURL: String
    let receivedEventsURL, type: String
    let siteAdmin: Bool
    let contributions: Int
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case contributions
    }
}
