//
//  KNetworker+URLSessionConfiguration.swift
//  KNetworker
//
//  Created by saeng lin on 3/29/24.
//

import Foundation

extension KlyNetworker {
    static var Configuration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        return configuration
    }
}
