//
//  MainViewModel.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    enum Destination: Equatable, Sendable {
        case splash
        case home
    }
    
    @Published @MainActor
    private(set) var destination: Destination = .splash
}

extension MainViewModel {
    
    /// Splash 이벤트 3초 후 메인 화면으로 이동
    func onAppear() async {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        await MainActor.run {
            destination = .home
        }
    }
}
