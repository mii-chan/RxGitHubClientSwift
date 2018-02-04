//
//  String+Prefix.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

extension String {
    var firstLetter: String {
        return "\(self.prefix(1))"
    }
    
    var withNoFirstLetter: String {
        return "\(self.suffix(self.count-1))"
    }
}
