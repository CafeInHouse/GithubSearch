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
        NavigationStack(root: {
            switch viewModel.viewState {
            case .cache(let keywordList):
                // MARK: - 기본 화면 ( 저장 된 검색 리스트 )
                CacheView(keywordAction: { keyword in
                    await viewModel.cacheSearch(with: keyword)
                }, removeKeyword: { removeKeyword in
                    await viewModel.removeKeyword(with: removeKeyword)
                }, removeAllAction: {
                    await viewModel.removeAll()
                })
                .environmentObject(CacheViewModel(searchKeywordList: keywordList))
                .listStyle(.plain)
                .navigationTitle("Search")
                
            case .search(let searchItems):
                // MARK: - 검색 결과 화면 ( Github 검색 화면 리스트 )
                SearchView()
                    .environmentObject(SearchViewModel(searchItems: searchItems))
                    .listStyle(.plain)
                    .navigationTitle("Search")
                
            case .searching(let filterKeywordList):
                // MARK: - 검색 중 과거 검색 했던 리스트를 보여주는 화면 ( 과거 검색 리스트 )
                SearchingView()
                    .environmentObject(SearchingViewModel(keywordList: filterKeywordList))
                    .listStyle(.plain)
                    .navigationTitle("Search")
            }
        })
        // MARK: - 서치바
        .searchable( // <-
            text: .init(get: {
                return viewModel.keyword ?? ""
            }, set: { newKeyWord in
                Task { @MainActor in
                    await viewModel.onSearch(with: newKeyWord)
                }
            }),
            placement: .automatic,
            prompt: "저장소 검색"
        )
    }
}

#Preview {
    HomeView()
}
