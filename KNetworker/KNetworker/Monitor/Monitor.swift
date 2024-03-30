//
//  Monitor.swift
//  KNetworker
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

/// 시간을 측정하는 객체
struct Monitor {
    let startTime: CFAbsoluteTime

    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }

    func stop() -> CFAbsoluteTime {
        return CFAbsoluteTimeGetCurrent() - startTime
    }
}
