//
//  App.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

struct ServiceApp {
    
    static private(set) var phase: Phase = .product
    
    static func inject(phase: Phase) async {
        self.phase = phase
    }
}
