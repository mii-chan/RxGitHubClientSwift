//
//  AppDelegate.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/04.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let container = Assembler([
        NetworkingAssembly(),
        RepoListAssembly(),
        RepoDetailAssembly(),
        ReposSplitAssembly()
        ]).resolver
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = container.resolve(CustomSplitViewController.self)!
        window?.makeKeyAndVisible()
        
        return true
    }
}
