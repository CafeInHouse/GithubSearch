//
//  Requester.swift
//  KNetworker
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

// Networker 객체에 주입해줘야하는 protocol
public protocol Requester {
    
    /// 네트워크 Endpoint
    /// - Parameter urlRequest: 요청하는 정보가 포함 된 URLRequest
    /// - Returns: 요청 결과
    func request(urlRequest: URLRequest) async throws -> (Data, URLResponse)
}

// 의존성 주입 (DI)
extension URLSession: Requester {
    
    /// 네트워크 Endpoint
    /// - Parameter urlRequest: 요청하는 정보가 포함 된 URLRequest
    /// - Returns: 요청 결과
    public func request(
        urlRequest: URLRequest
    ) async throws -> (Data, URLResponse) {
        try await data(for: urlRequest)
    }
}
