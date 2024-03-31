//
//  SearchingViewModel.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/31/24.
//

import Foundation

class SearchingViewModel: ObservableObject {
    
    let keywordList: [String]
    
    init(keywordList: [String]) {
        self.keywordList = keywordList
    }
}
