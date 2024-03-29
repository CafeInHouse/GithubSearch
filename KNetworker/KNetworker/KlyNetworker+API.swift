//
//  KlyNetworker+API.swift
//  KlyNetworker
//
//  Created by saeng lin on 3/29/24.
//

import Foundation

public protocol APIable {
    var path: String { get }
    var params: [String: Any]? { get }
    var method: KlyNetworker.Method { get }
}
