//
//  HomeCacheWorkerable.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/31/24.
//

import Foundation

import Swift

protocol HomeCacheWorkerable {
    func saveStringList(_ keywordList: [String])
    func loadStringList() -> [String]
    func removeStringFromList(_ stringToRemove: String) -> [String]
    func removeAll() -> [String]
}

struct HomeCacheWorker: HomeCacheWorkerable {
    
    private let key: String = "SearchList"
    
    // UserDefaults에 문자열 목록 저장
    func saveStringList(_ keywordList: [String]) {
        UserDefaults.standard.set(keywordList, forKey: key)
    }

    func loadStringList() -> [String] {
        return UserDefaults.standard.stringArray(forKey: key) ?? []
    }

    func removeStringFromList(_ stringToRemove: String) -> [String] {
        if var keywordList = UserDefaults.standard.stringArray(forKey: key) {
            keywordList.removeAll { $0 == stringToRemove }
            UserDefaults.standard.set(keywordList, forKey: key)
            return loadStringList()
        }
        return loadStringList()
    }
    
    func removeAll() -> [String] {
        let keywordList: [String] = []
        UserDefaults.standard.set(keywordList, forKey: key)
        return loadStringList()
    }
}
