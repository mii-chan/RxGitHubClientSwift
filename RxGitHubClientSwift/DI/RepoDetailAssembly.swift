//
//  RepoDetailAssembly.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Swinject

final class RepoDetailAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RepoDetailViewModelType.self) { resolver in
            let repository = resolver.resolve(RepoRepositoryType.self)!
            return RepoDetailViewModel(repository: repository)
        }
        
        container.register(RepoDetailViewController.self) { resolver in
            let viewModel = resolver.resolve(RepoDetailViewModelType.self)!
            return RepoDetailViewController(viewModel: viewModel)
        }
    }
}
