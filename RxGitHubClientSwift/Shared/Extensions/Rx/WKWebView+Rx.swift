//
//  WKWebView+Rx.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/19.
//

import WebKit
import RxSwift
import RxCocoa

extension Reactive where Base: WKWebView {
    
    /// Reactive wrapper for `url` property.
    public var url: Observable<URL?> {
        return self.observeWeakly(URL.self, "URL")
    }
    
    /// Reactive wrapper for `canGoBack` property.
    public var canGoBack: Observable<Bool> {
        return self.observeWeakly(Bool.self, "canGoBack")
            .map { $0 ?? false }
    }
    
    /// Reactive wrapper for `canGoForward` property.
    public var canGoForward: Observable<Bool> {
        return self.observeWeakly(Bool.self, "canGoForward")
            .map { $0 ?? false }
    }
    
    /// Reactive wrapper for `loading` property.
    public var loading: Observable<Bool> {
        return self.observeWeakly(Bool.self, "loading")
            .map { $0 ?? false }
    }
    
    /// Reactive wrapper for `estimatedProgress` property.
    public var estimatedProgress: Observable<Double> {
        return self.observeWeakly(Double.self, "estimatedProgress")
            .map { $0 ?? 0.0 }
    }
}
