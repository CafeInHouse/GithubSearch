//
//  onExpandTapGesture.swift
//  KUI
//
//  Created by saeng lin on 3/30/24.
//

import SwiftUI

extension View {
    public func onExpandTapGesture(perform action: @escaping () -> Void) -> some View {
        self.contentShape(Rectangle())
            .onTapGesture(perform: action)
    }
}
