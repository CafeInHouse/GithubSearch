//
//  KNetworker+Phase.swift
//  KNetworker
//
//  Created by saeng lin on 3/29/24.
//

import Foundation

extension KlyNetworker {
    
    public enum Phase: Equatable, Sendable {
        
        // real
        case product
        
        // dev
        case dev
        
        public var prefix: String {
            switch self {
            case .product:
                return ""
            case .dev: 
                return ""
            }
        }
    }
}
