//
//  KlyNetworker+Error.swift
//  KNetworker
//
//  Created by saeng lin on 3/30/24.
//

import Foundation


public enum KlyError: Error, Sendable {
    case invalidURL
    case invalidStatus(Int)
    case unowned(Error)
}
