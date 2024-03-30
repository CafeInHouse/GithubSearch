//
//  MockRequester.swift
//  KNetworkerTester
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

@testable import KNetworker

struct MockRequester: Requester {
    
    private let data: Data
    private let response: URLResponse
    
    init(data: Data, response: URLResponse) {
        self.data = data
        self.response = response
    }
    
    func request(
        urlRequest: URLRequest
    ) async throws -> (Data, URLResponse) {
        return (data, response)
    }
}
