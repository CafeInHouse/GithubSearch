//
//  KUI+Bundle.swift
//  KUI
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

private class _Class {}
public extension Bundle {

    static var kui: Bundle = {
        return Bundle(for: _Class.self)
    }()
}
