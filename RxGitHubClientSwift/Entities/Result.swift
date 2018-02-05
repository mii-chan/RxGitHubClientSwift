//
//  Result.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
    
    init(value: Value) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
}
