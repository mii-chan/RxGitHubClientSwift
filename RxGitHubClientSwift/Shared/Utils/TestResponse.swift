//
//  TestResponse.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import Foundation
import Moya

enum TestResponse {
    static func stubData(_ fileName: String) -> Data! {
        class TestData {}
        
        let bundle = Bundle(for: TestData.self)
        return try? Data(contentsOf: URL(fileURLWithPath: bundle.path(forResource: fileName, ofType: "json")!))
    }
}
