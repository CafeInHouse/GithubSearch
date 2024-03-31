//
//  CacheViewModel.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/31/24.
//

import Foundation

final class CacheViewModel: ObservableObject {
    
    private(set) var searchKeywordList: [String] = []
    
    init(searchKeywordList: [String]) {
        self.searchKeywordList = searchKeywordList
    }
}
