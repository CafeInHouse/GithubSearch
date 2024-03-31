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
        case cache(cacheKeywordList: [String]) // 기본 화면 ( 과거 검색 리스트 )
        case search(searchItems: [SearchItemModel]) // 검색 결과 화면
        case searching // 검색 중 과거 검색 리스트를 보여주는 화면
    }
    
    private let networkerDependency: HomeNetworkerDependency
    private var netwoekrTask: Task<Void, Never>?
    
    private let cacheDepdency: HomeCacheWorkerable
    private var cacheKeywordList: [String] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        netwoekrTask?.cancel()
    }
    
    init(
        networkerDependency: HomeNetworkerDependency = HomeViewNetWorker(),
        cacheDepdency: HomeCacheWorkerable = HomeCacheWorker()
    ) {
        self.networkerDependency = networkerDependency
        self.cacheDepdency = cacheDepdency
        bind()
    }
    
    @Published @MainActor
    private(set) var viewState: ViewState = .cache(cacheKeywordList: [])
    
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
            await MainActor.run { [weak self] in
                self?.viewState = .cache(cacheKeywordList: self?.cacheKeywordList ?? [])
            }
            return
        }
        
        
        if cacheKeywordList.contains(keyword) == false {
            cacheKeywordList.append(keyword)
        }
        cacheDepdency.saveStringList(cacheKeywordList)
        
        netwoekrTask = Task {
            do {
                let searchmodel = try await self.networkerDependency.search(with: keyword)
                
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
    
    /// 생명주기 - 저장되어 있는 keyword list를 호출함
    func onAppear() async {
        let cacheKeywordList = cacheDepdency.loadStringList()
        self.cacheKeywordList = cacheKeywordList
        await MainActor.run { [weak self] in
            self?.viewState = .cache(cacheKeywordList: cacheKeywordList)
        }
    }
    
    /// searchbar에서 검색 debounce 3초
    /// - Parameter keyword: 검색 keyword
    func onSearch(with keyword: String) {
        self.keyword = keyword
    }
    
    /// 즉시 검색
    /// - Parameter keyword: 검색 keyword
    func cacheSearch(with keyword: String) async {
        self.keyword = keyword
        await requestSearch(keyword: keyword)
    }
    
    /// 저장 된 keyword 삭제
    func removeAll() async {
        self.cacheKeywordList = cacheDepdency.removeAll()
        await MainActor.run { [weak self] in
            self?.viewState = .cache(cacheKeywordList: self?.cacheKeywordList ?? [])
        }
    }
    
    func removeKeyword(with keyword: String) async {
        self.cacheKeywordList = cacheDepdency.removeStringFromList(keyword)
        await MainActor.run { [weak self] in
            self?.viewState = .cache(cacheKeywordList: self?.cacheKeywordList ?? [])
        }
    }
}
