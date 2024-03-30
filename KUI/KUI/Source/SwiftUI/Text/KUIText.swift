//
//  KUIText.swift
//  KUI
//
//  Created by saeng lin on 3/30/24.
//

import SwiftUI

public struct KUIText: View {
    
    private let text: String
    private let textColor: Color
    private let weight: Font.Weight
    private let size: CGFloat
    
    /// 초기화
    /// - Parameters:
    ///   - text: Text 이름
    ///   - textColor: Text Color
    ///   - weight: bold, semibold
    ///   - size: font size
    public init(
        text: String,
        textColor: Color = .kui.grey,
        weight: Font.Weight,
        size: CGFloat
    ) {
        self.text = text
        self.textColor = textColor
        self.weight = weight
        self.size = size
    }
    
    public var body: some View {
        Text(text)
            .fontWeight(weight)
            .font(.system(size: size))
            .foregroundColor(textColor)
    }
}

#Preview {
    KUIText(
        text: "린생",
        weight: .bold,
        size: 40
    )
}
