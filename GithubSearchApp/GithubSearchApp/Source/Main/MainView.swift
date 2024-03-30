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
        bodyView
            .onceTask {
                await viewModel.onAppear()
            }
    }
    
    @ViewBuilder
    private var bodyView: some View {
        switch viewModel.destination {
        case .splash:
            // MARK: - SplashView
            SplashView()

        case .home:
            // MARK: - HomeView
            HomeView()
        }
    }
}
