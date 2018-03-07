//
//  RepoListAssembly.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Swinject

final class RepoListAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RepoRepositoryType.self) { resolver in
            let gitHubService = resolver.resolve(GitHubServiceType.self)!
            return RepoRepository(gitHubService: gitHubService)
        }
        
        container.register(RepoListViewModelType.self) { resolver in
            let repository = resolver.resolve(RepoRepositoryType.self)!
            return RepoListViewModel(repository: repository)
        }
        
        container.register(RepoListViewController.self) { resolver in
            let viewModel = resolver.resolve(RepoListViewModelType.self)!
            return RepoListViewController(viewModel: viewModel)
        }
    }
}
