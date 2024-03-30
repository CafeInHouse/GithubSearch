//
//  MainView.swift
//  [Product] GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import SwiftUI

import KUI

struct MainView: View {
    
    @ObservedObject
    private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.destination {
        case .splash:
            SplashView()
                .onceTask {
                    await viewModel.onAppearSplash()
                }
            
        case .home:
            HomeView()
        }
    }
}

#Preview {
    MainView(
        viewModel: MainViewModel()
    )
}
