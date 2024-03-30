//
//  SearchModel.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

struct SearchModel: Decodable, Sendable, Hashable {
    let items: [SearchItemModel]
}

struct SearchItemModel: Decodable, Sendable, Hashable {
    
    var id: Int
    let name: String
    let owner: SearchOwner
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
    }
}

struct SearchOwner: Decodable, Sendable, Hashable {
    var id: Int
    let thumbnail: URL
    let url: URL
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case thumbnail = "avatar_url"
        case url = "html_url"
        case description = "login"
    }
}
