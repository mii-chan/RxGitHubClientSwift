//
//  InternetConnection.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Alamofire

enum InternetConnection {
    static var isOnline: Bool {
        guard let manager = NetworkReachabilityManager() else { fatalError() }
        return manager.isReachable
    }
}
