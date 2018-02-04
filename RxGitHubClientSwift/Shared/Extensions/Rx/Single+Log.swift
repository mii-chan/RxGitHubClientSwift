//
//  Single+Log.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import RxSwift
import Moya

extension Single {
    func log() -> Single<Element> {
        return self
            .asObservable()
            .do(onError: { error in
                print("\(error)")
            }).asSingle()
    }
}
