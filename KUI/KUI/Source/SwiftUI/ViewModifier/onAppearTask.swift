//
//  onAppearTask.swift
//  KUI
//
//  Created by saeng lin on 3/30/24.
//

import SwiftUI

struct ViewOnceTaskModifier: ViewModifier {

    @State private var isAppeared = false
    private let action: @Sendable () async -> Void

    init(perform action: @escaping @Sendable () async -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppearTask {
            guard isAppeared == false else {
                return
            }
            isAppeared = true
            await action()
        }
    }
}

extension View {

    /// 최초 1회만 호출 되는 Task
    /// - Parameter action: 처음 진입시 한번만 호출되는 동작
    /// - Returns:
    public func onceTask(perform action: @escaping @Sendable () async -> Void) -> some View {
        modifier(ViewOnceTaskModifier(perform: action))
    }
}

extension View {

    /// onAppear가 수행 되고 끝나기 전에 호출되는 task
    /// - Parameter action: onAppear 시점에 task를 수행하기 위해 필요한 task
    /// - Returns: View
    public func onAppearTask(perform action: @escaping @Sendable () async -> Void) -> some View {
        return onAppear {
            Task { @MainActor in
                await action()
            }
        }
    }
}
