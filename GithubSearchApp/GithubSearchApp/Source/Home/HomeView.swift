//
//  HomeView.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import SwiftUI

import KUI

struct HomeView: View {
    
    @StateObject
    private var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        bodyView
            .onceTask {
                await viewModel.onAppear()
            }
    }
    
    @MainActor
    private var bodyView: some View {
        NavigationView {
            switch viewModel.viewState {
            case .cache:
                // MARK: - 기본 화면 ( 저장 된 검색 리스트 )
                Text("캐시")
                
            case .search:
                // MARK: - 검색 결과 화면 ( Github 검색 화면 리스트 )
                Text("서치")
                
            case .searching:
                // MARK: - 검색 중 과거 검색 했던 리스트를 보여주는 화면 ( 과거 검색 리스트 )
                Text("검색중")
            }
        }
        // MARK: - 서치바
        .searchable( // <-
            text: .init(get: {
                return viewModel.keyword ?? ""
            }, set: { newKeyWord in
                Task {
                    await viewModel.onSearch(with: newKeyWord)
                }
            }),
            placement: .navigationBarDrawer,
            prompt: "저장소 검색"
        )
    }
}

#Preview {
    HomeView()
}
