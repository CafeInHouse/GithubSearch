//
//  HomeAPI.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

import KNetworker

enum HomeAPI {
    case search(keyword: String)
}

extension HomeAPI: APIable {
    var path: String {
        switch self {
        case .search:
            return "https://api.github.com/search/repositories"
        }
    }
    
    var params: [String : Any]? {
        switch self {
        case .search(let keyword):
            return ["q": keyword]
        }
    }
    
    var method: KlyNetworker.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    
}
