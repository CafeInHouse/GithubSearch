//
//  DeubgView.swift
//  KUI
//
//  Created by saeng lin on 3/30/24.
//

import SwiftUI

extension View {
    public func debugView() -> some View {
        overlay {
            Color(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1)
            ).opacity(0.5)
        }
    }
}
