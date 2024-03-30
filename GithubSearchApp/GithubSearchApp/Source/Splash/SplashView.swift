//
//  Splash.swift
//  [Product] GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import SwiftUI

import KUI

// MARK: - SplashView
struct SplashView: View {
    
    private let viewModel = SplashViewModel()
    
    var body: some View {
        bodyView
            .onceTask {
                await viewModel.onAppear()
            }
    }
    
    private var bodyView: some View {
        VStack(spacing: .zero) {
            serviceTextView
            phaseTextView
        }
    }
    
    private var serviceTextView: some View {
        ServiceTextView(viewModel: viewModel)
            .padding(.horizontal, 10)
    }
    
    private var phaseTextView: some View {
        ServicePhaseView(viewModel: viewModel)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
    }
}

// MARK: - Text View
private struct ServiceTextView: View {
    
    @ObservedObject
    private var viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        KUIText(
            text: viewModel.serviceTitle,
            weight: .bold,
            size: 30)
    }
}

// MARK: - Phase View
private struct ServicePhaseView: View {
    
    @ObservedObject
    private var viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        KUIText(
            text: viewModel.phaseTitle,
            weight: .bold,
            size: 20)
    }
}

#Preview {
    SplashView()
}
