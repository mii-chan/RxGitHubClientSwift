//
//  NetworkingAssembly.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Swinject
import Moya

final class NetworkingAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MoyaProvider<AnyGitHubTarget>.self) { resolver in
            return MoyaProvider<AnyGitHubTarget>()
            }.inObjectScope(.container)
        
        container.register(GitHubService.self) { resolver in
            let provider = resolver.resolve(MoyaProvider<AnyGitHubTarget>.self)!
            return GitHubService(provider: provider)
            }.inObjectScope(.container)
    }
}
