//
//  CustomSplitViewController.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit

class CustomSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
