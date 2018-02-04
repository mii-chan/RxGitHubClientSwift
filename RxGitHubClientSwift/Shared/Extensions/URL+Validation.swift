//
//  URL+Validation.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit

extension URL {
    var isValid: Bool {
        return UIApplication.shared.canOpenURL(self)
    }
}
