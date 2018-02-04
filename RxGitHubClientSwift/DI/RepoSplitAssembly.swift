//
//  RepoSplitAssembly.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit
import Swinject

final class ReposSplitAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CustomSplitViewController.self) { resolver in
            let splitVC = CustomSplitViewController()
            let masterVC = resolver.resolve(RepoListViewController.self)!
            let detailVC = resolver.resolve(RepoDetailViewController.self)!
            
            masterVC.detailVC = detailVC
            splitVC.addChildViewController(UINavigationController(rootViewController: masterVC))
            splitVC.addChildViewController(UINavigationController(rootViewController: detailVC))
            
            detailVC.navigationItem.leftItemsSupplementBackButton = true
            detailVC.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
            
            return splitVC
        }
    }
}
