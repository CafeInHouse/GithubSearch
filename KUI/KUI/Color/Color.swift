//
//  Color.swift
//  KUI
//
//  Created by saeng lin on 3/30/24.
//

import SwiftUI

extension KlyUI where Base == Color {
    public static var white: Color { Color(uiColor: UIColor.kui.white) }
    public static var black: Color { Color(uiColor: UIColor.kui.black) }
    
    public static var grey: Color { Color(uiColor: UIColor.kui.grey) }
    public static var grey1: Color { Color(uiColor: UIColor.kui.grey1) }
    
    public static var background: Color { Color(uiColor: UIColor.kui.background) }
    public static var background1: Color { Color(uiColor: UIColor.kui.background1) }
}

extension KlyUI where Base == UIColor {
    
    public static var white: UIColor { asset(#function) }
    public static var black: UIColor { asset(#function) }
    
    public static var grey: UIColor { asset(#function) }
    public static var grey1: UIColor { asset(#function) }
    
    public static var background: UIColor { asset(#function) }
    public static var background1: UIColor { asset(#function) }
    
    private static func asset(_ name: String) -> UIColor {
        let assetName = "kui_" + name
        
        guard let color = UIColor(named: assetName, in: .kui, compatibleWith: nil) else {
            assertionFailure("can't find color asset: \(assetName)")
            return UIColor.clear
        }
        return color
        
    }
}
