//
//  HomeNetworkerDependency.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

import KNetworker

protocol HomeNetworkerDependency {
    func search(with keyword: String) async throws -> SearchModel
}

struct HomeViewNetWorker: HomeNetworkerDependency {
    
    /// 검색 API
    /// - Parameter keyword: 검색 키워드
    /// - Returns: 검색 결과
    func search(
        with keyword: String
    ) async throws -> SearchModel {
        let searchAPI = HomeAPI.search(keyword: keyword)
        
        switch ServiceApp.phase {
        case .product:
            return try await KlyNetworker.product.request(api: searchAPI)
            
        case .develop:
            return try await KlyNetworker.develop.request(api: searchAPI)
        }
    }
}
