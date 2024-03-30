//
//  HomeViewModel.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    enum ViewState: Equatable, Sendable {
        case cache // 기본 화면 ( 과거 검색 리스트 )
        case search(searchItems: [SearchItemModel]) // 검색 결과 화면
        case searching // 검색 중 과거 검색 리스트를 보여주는 화면
    }
    
    private let networkerDpendency: HomeNetworkerDependency
    private var netwoekrTask: Task<Void, Never>?
    
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        netwoekrTask?.cancel()
    }
    
    init(
        networkerDpendency: HomeNetworkerDependency = HomeViewNetWorker()
    ) {
        self.networkerDpendency = networkerDpendency
        bind()
    }
    
    @Published @MainActor
    private(set) var viewState: ViewState = .cache
    
    @Published
    private(set) var keyword: String?
    
    @Published
    private(set) var error: Error?
    
    private func bind() {
        $keyword
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] keyword in
                Task { [weak self] in
                    await self?.requestSearch(keyword: keyword)
                }
            })
            .store(in: &cancellables)
    }
    
    private func requestSearch(keyword: String?) async {
        netwoekrTask?.cancel()
        
        guard let keyword = keyword, keyword.isEmpty == false else {
            Task {
                await MainActor.run { [weak self] in
                    self?.viewState = .cache
                }
            }
            return
        }
        
        netwoekrTask = Task {
            do {
                let searchmodel = try await self.networkerDpendency.search(with: keyword)
                
                await MainActor.run { [weak self] in
                    self?.viewState = .search(searchItems: searchmodel.items)
                }
                
            } catch {
                await MainActor.run { [weak self] in
                    self?.error = error
                }
            }
        }
    }
}

extension HomeViewModel {
    
    func onAppear() async {}
    func onSearch(with keyword: String) {
        self.keyword = keyword
    }
}
