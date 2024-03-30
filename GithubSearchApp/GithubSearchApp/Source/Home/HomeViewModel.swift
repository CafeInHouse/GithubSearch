//
//  HomeViewModel.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    enum ViewState: Equatable, Sendable {
        case cache // 기본 화면 ( 과거 검색 리스트 )
        case search // 검색 결과 화면
        case searching // 검색 중 과거 검색 리스트를 보여주는 화면
    }
    
    @Published @MainActor
    private(set) var viewState: ViewState = .cache
    
    @Published
    private(set) var keyword: String?
}

extension HomeViewModel {
    
    func onAppear() async {}
    func onSearch(with keyword: String) async {}
}
