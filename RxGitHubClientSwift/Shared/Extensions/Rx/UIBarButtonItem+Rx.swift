//
//  UIBarButtonItem+Rx.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIBarButtonItem {
    
    /// Bindable sink for `isEnabled` property
    public var isEnabled: Binder<Bool> {
        return Binder(self.base) { barButtonItem, value in
            barButtonItem.isEnabled = value
        }
    }
}
