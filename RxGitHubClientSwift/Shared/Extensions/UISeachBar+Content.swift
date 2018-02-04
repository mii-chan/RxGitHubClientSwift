//
//  UISeachBar+Content.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit

extension UISearchBar {
    var textField: UITextField? {
        return self.value(forKey: "searchField") as? UITextField
    }
}
