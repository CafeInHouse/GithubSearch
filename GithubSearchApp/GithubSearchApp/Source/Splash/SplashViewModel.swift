//
//  SplashViewModel.swift
//  [Product] GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

final class SplashViewModel: ObservableObject {
    @Published private(set) var serviceTitle: String = ""
    @Published private(set) var phaseTitle: String = ""
}

extension SplashViewModel {
    
    func onAppear() async {
        await MainActor.run { [weak self] in
            self?.serviceTitle = "Github Search App"
            self?.phaseTitle = "Phase:: \(ServiceApp.phase)"
        }
    }
}
