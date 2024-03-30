//
//  KUI.swift
//  KUI
//
//  Created by saeng lin on 3/30/24.
//

import UIKit
import SwiftUI

public struct KlyUI<Base> {
    
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol KUISupportable {
    associatedtype KUIBase
    
    static var kui: KlyUI<KUIBase>.Type { get set }

    var kui: KlyUI<KUIBase> { get set }
}

extension KUISupportable {
    
    public static var kui: KlyUI<Self>.Type {
        get { KlyUI<Self>.self }
        set { }
    }

    public var kui: KlyUI<Self> {
        get { KlyUI(self) }
        set { }
    }
}

extension UIColor: KUISupportable {}
extension Color: KUISupportable {}
