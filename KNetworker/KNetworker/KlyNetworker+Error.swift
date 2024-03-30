//
//  KlyNetworker+Error.swift
//  KNetworker
//
//  Created by saeng lin on 3/30/24.
//

import Foundation


public enum KlyError: Error, Equatable, Sendable {
    case invalidURL
    case invalidStatus(Int)
    case invalidDecode
    case unowned(message: String)
}
