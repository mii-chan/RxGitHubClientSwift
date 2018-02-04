//
//  UIProgressView+Rx.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIProgressView {
    
    /// Bindable sink for `progress` property
    public var progress: Binder<Float> {
        return Binder(self.base) { progressView, value in
            progressView.progress = value
        }
    }
}
