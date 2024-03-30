//
//  MockAPI+InValidURL.swift
//  KNetworkerTester
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

@testable import KNetworker

enum MockAPI {
    case invalid
    case invalidURL
}

extension MockAPI: APIable {
    
    var path: String {
        switch self {
        case .invalidURL:
            return "invalid Error"
        
        case .invalid:
            return "invalid"
        }
    }
    
    var params: [String : Any]? {
        nil
    }
    
    var method: KlyNetworker.Method {
        KlyNetworker.Method.get
    }
}
