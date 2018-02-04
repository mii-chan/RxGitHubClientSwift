//
//  Nib.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit

enum Nib {
    static func nib<T: UIView>(_ type: T.Type) -> UINib {
        return UINib(nibName: String(describing: type), bundle: Bundle(for: type))
    }
    
    static func view<T: UIView>(_ owner: T) -> UIView? {
        return nib(T.self).instantiate(withOwner: owner, options: nil).first as? UIView
    }
}
